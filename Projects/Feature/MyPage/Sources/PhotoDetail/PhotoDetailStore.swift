//
//  PhotoDetailStore.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/17/24.
//

import UIKit

import ComposableArchitecture

import FeatureMyPageInterface
import DomainAlbumSaver
import DomainAlbumSaverInterface
import SharedUtil

extension PhotoDetailStore {
  public init() {
    
    @Dependency(\.albumSaverClient) var albumSaver
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .none
        case .closeButtonTapped:
          return .none
          
        case let .saveButtonTapped(isShow):
          state.showSaveActionSheet = isShow
          
          return .none
          
        case let .closeDraged(height):
          state.closeDragHeight = height
          
          if abs(height) > 250 {
            return .send(.closeButtonTapped)
          }
          
          return .none
          
        case let .startCloseDrag(isStart):
          state.isDrag = isStart
          return .none
          
        case let .offsetChanged(offset):
          let screenWidth = UIScreen.main.bounds.width
          let pageIndex = Int(offset / screenWidth)
          
          return .run { send in
            await send(.currentPage(pageIndex))
          }
          .throttle(
            id: CancelID.throttle,
            for: 0.3,
            scheduler: DispatchQueue.main,
            latest: true
          )
          
        case let .currentPage(page):
          state.currentPage = page + 1
          state.index = page
          
          return .none
          
        case .saveOnlyPhotoButtonTapped:
          state.isSaving = true
          let image = ImageCache.shared.loadImageFromDiskCache(
            forKey: state.names[state.index]
          ) ?? UIImage()
          
          return .run { [image] send in
            await send(.savePhotoResponse(TaskResult {
              try await albumSaver.savePhoto(image)
            }))
          }
          
        case let .savePhotoResponse(result):
          switch result {
            case .success:
              return .run { send in
                await send(.saveCompleted(true))
              }
            case let .failure(error):
              if error as? AlbumSaverError == AlbumSaverError.denied {
                return .run { send in
                  await send(.showGoToSettingAlert)
                }
              } else {
                return .run { send in
                  await send(.saveCompleted(false))
                }
              }
          }
          
        case .saveTimeLapseButtonTapped:
          state.isSaving = true
          
          return .run { [state] send in
            await send(.savePhotoResponse(TaskResult {
              try await albumSaver.saveVideo(state.names)
            }))
          }
          
        case let .saveCompleted(isComplete):
          state.isSaveSuccess = isComplete
          state.showSaveSuccessAnimaion = isComplete
          state.isSaving = false
          return .none
        
        case let .showSaveCompletionAnimation(isShow):
          state.showSaveSuccessAnimaion = isShow
          return .none
          
        case .showGoToSettingAlert:
          state.isSaving = false
          state.alert = AlertState {
            TextState("사진을 앨범에 저장하려면 접근 권힌이 필요합니다.")
          } actions: {
            ButtonState(role: .none, action: .goSettingTapped) {
              TextState("설정 화면으로")
            }
            ButtonState(role: .cancel, action: .cancelTapped) {
              TextState("취소")
            }
          }
          
          return .none
          
        case .alert(.presented(.goSettingTapped)):
          state.alert = nil
          
          guard let url = URL(string: UIApplication.openSettingsURLString) else { return .none }

          if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
          }
          
          return .none
          
        case .alert(.presented(.cancelTapped)):
          state.alert = nil
          
          return .none
          
        case .alert:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
