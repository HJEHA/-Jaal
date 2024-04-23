//
//  PhotoDetailStore.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/17/24.
//

import UIKit

import ComposableArchitecture

import FeatureMyPageInterface
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
          print(result)
          switch result {
            case .success:
              return .run { send in
                await send(.saveCompleted(true))
              }
            case .failure:
              return .run { send in
                await send(.saveCompleted(false))
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
      }
    }
    
    self.init(reducer: reducer)
  }
}
