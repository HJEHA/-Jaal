//
//  FaceTrackingStore.swift
//  FeatureMeasurement
//
//  Created by 황제하 on 3/29/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurementInterface

extension FaceTrackingStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .snapshot:
          state.isSnapshot = true
          return .none
          
        case .saveImage:
          state.isSnapshot = false
          return .none
          
        default:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
