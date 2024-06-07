//
//  ActivityDetailStore.swift
//  FeatureRecordInterface
//
//  Created by 황제하 on 4/15/24.
//

import Foundation

import ComposableArchitecture

import FeatureRecordInterface

extension ActivityDetailStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          state.sortedTimeLapse = state.activity.timelapse.sorted(
            by: { $0.name < $1.name }
          )
          return .none
          
        case let .thumbnailTapped(index):
          let names: [String] = state.sortedTimeLapse.map { $0.name }
          state.photoDetail = .init(names: names, index: index)
          return .none
          
        case .photoDetail(.presented(.closeButtonTapped)):
          state.photoDetail = nil
          return .none
          
        default:
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      photoDetail: PhotoDetailStore()
    )
  }
}
