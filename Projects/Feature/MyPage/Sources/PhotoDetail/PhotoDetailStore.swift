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
            for: 0.5,
            scheduler: DispatchQueue.main,
            latest: true
          )
          
        case let .currentPage(page):
          state.currentPage = page + 1
          state.index = page
          
          return .none
          
        case .saveOnlyPhotoButtonTapped:
          state.isSaving = true
          return .none
          
        case .saveTimeLapseButtonTapped:
          state.isSaving = true
          return .none
          
        case let .saveCompleted(isComplete):
          state.isSaveSuccess = isComplete
          state.isSaving = false
          print("complete", isComplete)
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
