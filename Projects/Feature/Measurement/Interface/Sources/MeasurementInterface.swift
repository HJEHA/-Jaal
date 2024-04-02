//
//  MeasurementInterface.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/01/24.
//

import ComposableArchitecture

public struct MeasurementStore: Reducer {

  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    public var selectedMode: MeasurementMode = .nomal
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case appear
    case modeButtonTapped(MeasurementMode)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

public enum MeasurementMode {
  case nomal
  case focus
  
  var title: String {
    switch self {
      case .nomal:
        return "일반 모드"
      case .focus:
        return "집중 모드"
    }
  }
}
