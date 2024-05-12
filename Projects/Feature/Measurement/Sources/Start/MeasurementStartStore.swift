//
//  MeasurementStartStore.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 5/12/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurementInterface

extension MeasurementStartStore {
  public init() {
    
    @Dependency(\.continuousClock) var clock
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .send(.initialTimerStart)
        
        case .initialTimerStart:
          return .run { send in
            for await _ in clock.timer(interval: .seconds(1)) {
              await send(.initialTimerTicked)
            }
          }
          .cancellable(id: CancelID.timer)
        
        case .initialTimerTicked:
          if state.initialTimerCount == 0 {
            return .concatenate([
              .send(.initialEnded),
              .cancel(id: CancelID.timer)
            ])
          }
          
          state.initialTimerCount -= 1
          return .none
        
        default:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
