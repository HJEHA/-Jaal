//
//  MeasurementStore.swift
//  FeatureMeasurement
//
//  Created by 황제하 on 4/01/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurementInterface

extension MeasurementRootStore {
  public init() {
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .appear:
          return .none
        case let .modeButtonTapped(mode):
          state.selectedMode = mode
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
