//
//  MainTabStore.swift
//  Feature
//
//  Created by 황제하 on 3/29/24.
//

import Foundation

import ComposableArchitecture

import FeatureHome
import FeatureHomeInterface
import FeatureMeasurement
import FeatureMeasurementInterface
import FeatureMyPage
import FeatureMyPageInterface

@Reducer
public struct MainTabStore {
  public init() { }
  
  @ObservableState
  public struct State: Equatable {
    public var home: HomeRootStore.State = .init()
    public var measurement: MeasurementRootStore.State = .init()
    public var myPage: MyPageRootStore.State = .init()
    
    public var selection: Int = 0
    public init() {}
  }
  
  public enum Action: Equatable {
    case home(HomeRootStore.Action)
    case measurement(MeasurementRootStore.Action)
    case myPage(MyPageRootStore.Action)
    
    case selectionChanged(Int)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.home, action: /Action.home) {
      HomeRootStore()
    }
    Scope(state: \.measurement, action: /Action.measurement) {
      MeasurementRootStore()
    }
    Scope(state: \.myPage, action: /Action.myPage) {
      MyPageRootStore()
    }
    Reduce { state, action in
      switch action {
        case .home:
          return .none
          
        case .measurement:
          return .none
          
        case let .selectionChanged(selection):
          state.selection = selection
          print(selection)
          return .none
          
        case .myPage:
          return .none
      }
    }
  }
}
