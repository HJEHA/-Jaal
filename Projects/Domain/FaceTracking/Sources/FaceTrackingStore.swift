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
          return .run { send in
            await send(.changedFaceCenter(center))
          }
          .throttle(
            id: CancelID.throttle,
            for: 0.5,
            scheduler:DispatchQueue.main,
            latest: false
          )
          
        case let .eyeBlink(value):
          state.eyeBlink = value
          return .run { send in
            await send(.eyeBlink(value))
          }
          .throttle(
            id: CancelID.throttle,
            for: 0.5,
            scheduler:DispatchQueue.main,
            latest: false
          )
      }
    }
    
    self.init(reducer: reducer)
  }
}
