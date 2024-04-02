//
//  FaceTrackingStore.swift
//  DomainFaceTracking
//
//  Created by 황제하 on 3/29/24.
//

import Foundation

import ComposableArchitecture

import DomainFaceTrackingInterface

extension FaceTrackingStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case let .changedFaceCenter(center):
          state.faceCenter = center
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
