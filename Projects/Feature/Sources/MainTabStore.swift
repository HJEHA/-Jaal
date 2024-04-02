//
//  MainTabStore.swift
//  Feature
//
//  Created by 황제하 on 3/29/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurement
import FeatureMeasurementInterface

public struct MainTabStore: Reducer {
  public init() { }
  
  public struct State: Equatable {
    public var measurement: MeasurementRootStore.State = .init()
    
    public var currentScene: MainScene = .home
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case measurement(MeasurementRootStore.Action)
    
    case selectTab(MainScene)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.measurement, action: /Action.measurement) {
      MeasurementRootStore()
    }
    Reduce { state, action in
      switch action {
        case .measurement:
          return .none
          
        case let .selectTab(scene):
          state.currentScene = scene
          return .none
      }
    }
  }
}
