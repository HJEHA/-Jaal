//
//  MeasurementStartInterface.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 5/12/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MeasurementStartStore {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public enum CancelID {
    case timer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var initialTimerCount: Int = 5
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case onAppear
    case initialTimerTicked
    case initialTimerStart
    case initialEnded
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
