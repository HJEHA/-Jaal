//
//  PhotoDetailStore.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/17/24.
//

import UIKit

import ComposableArchitecture

import FeatureMyPageInterface

extension PhotoDetailStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .none
        case .nextButtonTapped:
          state.index = min(state.index + 1, state.names.count - 1)
          state.currentPage = state.index + 1
          return .none
        case .preButtonTapped:
          state.index = max(state.index - 1, 0)
          state.currentPage = state.index + 1
          return .none
        case .closeButtonTapped:
          return .none
        case let .offsetChanged(offset):
          let screenWidth = UIScreen.main.bounds.width
          let imagesCount = state.names.count
          let pageIndex = Int(offset / screenWidth)
          let clampedPageIndex = min(max(imagesCount - pageIndex - 1, 0), imagesCount)
          print(offset)
          
          return .run { send in
            await send(.currentPage(clampedPageIndex))
          }
          .throttle(
            id: CancelID.throttle,
            for: 0.3,
            scheduler: DispatchQueue.main,
            latest: true
          )
          
        case let .currentPage(page):
          if state.index != (page - 1) {
            state.currentPage = page
          }
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
