//
//  MeasurementStore.swift
//  FeatureMeasurement
//
//  Created by 황제하 on 4/2/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurementInterface

extension MeasurementStore {
  public init() {
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case let .faceTracking(action):
          switch action {
            case let .changedFaceCenter(center):
              state.faceCenter = center
              return .none
          }
          
        case .closeButtonTapped:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
