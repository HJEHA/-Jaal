//
//  MeasurementStore.swift
//  FeatureMeasurement
//
//  Created by 황제하 on 4/2/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurementInterface
import SharedUtil

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
              
            case .eyeBlink:
              state.eyeBlinkCount += 1
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
          return .run { send in
            for await _ in clock.timer(interval: .seconds(1)) {
              await send(.timerTicked)
            }
          }
          .cancellable(id: CancelID.timer)
          
        case .timerTicked:
          state.time += 1
          state.timeString = TimeFormatter.toClockString(from: state.time)
          
          guard let center = state.faceCenter,
                let initialCentre = state.initialFaceCenter
          else {
            return .none
          }
          //TODO: - 범위 조절 기능 추가(우측 화면 swipe)
          if initialCentre.distance(to: center) > 0.1 {
            state.isWarning = true
          } else {
            state.isWarning = false
          }
          return .none
          
        case .closeButtonTapped:
          return .concatenate([
            .cancel(id: CancelID.timer),
            .none
          ])
      }
    }
    
    self.init(reducer: reducer)
  }
}
