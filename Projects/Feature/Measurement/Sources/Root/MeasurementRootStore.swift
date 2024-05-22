//
//  MeasurementStore.swift
//  FeatureMeasurement
//
//  Created by 황제하 on 4/01/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurementInterface
import CoreUserDefaults

extension MeasurementRootStore {
  
  public init() {
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .none
        
        case let .modeButtonTapped(mode):
          state.selectedMode = mode
          return .none
        
        case .measurement(.presented(.saveActivity)):
          state.measurement = nil
          
          return .none
        
        case let .measurement(.presented(.saveActivityCompleted(activity))):
          state.end = .init(activity: activity)
          return .none
          
        case .end(.closeButtonTapped):
          state.end = nil
          
          return .none
          
        case .startButtonTapped:
          var title: String
          
          if state.title.isEmpty {
            title = KUUserDefaults.lastMeasurementTitle
          } else {
            KUUserDefaults.lastMeasurementTitle = state.title
            title = state.title
          }
          KUUserDefaults.timerValue = state.selectedTimerPickerItem
          KUUserDefaults.drowsinessTimerValue = state.selectedDrowsinessTimerPickerItem
          KUUserDefaults.isSaveTimeLapse = state.isSaveTimeLapse
          
          state.measurement = .init(
            title: title,
            mode: state.selectedMode
          )
          return .none
        
        default:
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      measurement: MeasurementStore(),
      end: MeasurementEndStore()
    )
  }
}
