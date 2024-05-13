//
//  MeasurementEndStore.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 5/13/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurementInterface

extension MeasurementEndStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        default:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
