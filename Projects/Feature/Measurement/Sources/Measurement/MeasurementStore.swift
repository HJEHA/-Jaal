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
    
    @Dependency(\.continuousClock) var clock
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case let .faceTracking(action):
          switch action {
            case let .changedFaceCenter(center):
              state.faceCenter = center
              return .none
          }
          
        case .appear:
          return .send(.initialTimerStart)
        
        case .initialTimerStart:
          state.isInitailing = true
          return .run { send in
            for await _ in clock.timer(interval: .seconds(1)) {
              await send(.initialTimerTicked)
            }
          }
          .cancellable(id: CancelID.timer)
          
        case .initialTimerTicked:
          if state.initialTimerCount == 0 {
            state.isInitailing = false
            state.initialFaceCenter = state.faceCenter
            return .concatenate([
              .send(.start),
              .cancel(id: CancelID.timer)
            ])
          }
          
          state.initialTimerCount -= 1
          return .none
          
        case .start:
          //TODO: - 거리 비교 시작, 실제 타이머 동작
          print("측정 시작")
          return .none
          
        case .closeButtonTapped:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
