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
import FeatureMyPage
import FeatureMyPageInterface

@Reducer
public struct MainTabStore {
  public init() { }
  
  @ObservableState
  public struct State: Equatable {
    public var measurement: MeasurementRootStore.State = .init()
    public var myPage: MyPageRootStore.State = .init()
    
    public var currentScene: MainScene = .home
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case measurement(MeasurementRootStore.Action)
    case myPage(MyPageRootStore.Action)
    
    case selectTab(MainScene)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.measurement, action: /Action.measurement) {
      MeasurementRootStore()
    }
    Scope(state: \.myPage, action: /Action.myPage) {
      MyPageRootStore()
    }
    Reduce { state, action in
      switch action {
        case .measurement:
          return .none
          
        case let .selectTab(scene):
          state.currentScene = scene
          return .none
          
        case .myPage(_):
          return .none
      }
    }
  }
}
