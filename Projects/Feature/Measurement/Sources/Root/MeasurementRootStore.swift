//
//  MeasurementStore.swift
//  FeatureMeasurement
//
//  Created by 황제하 on 4/01/24.
//

import UIKit

import ComposableArchitecture

import FeatureMeasurementInterface
import CoreUserDefaults
import SharedUtil

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
          if PermissionManager.checkARKitPermission() == false {
            return .send(.showNotSupportedAlert)
          }
          
          var title: String
          
          if state.title.isEmpty {
            title = KUUserDefaults.lastMeasurementTitle
          } else {
            KUUserDefaults.lastMeasurementTitle = state.title
            title = state.title
          }
          KUUserDefaults.timerValue = state.selectedTimerPickerItem
          KUUserDefaults.sleepTimerValue = state.selectedSleepTimerPickerItem
          KUUserDefaults.isSaveTimeLapse = state.isSaveTimeLapse
          
          state.measurement = .init(
            title: title,
            mode: state.selectedMode
          )
          
          return .none
          
        case .showNotSupportedAlert:
          state.alert = AlertState(title: {
            TextState("아쉽지만 기능을 사용할 수 없는 기기입니다.\n 다른 기기를 이용해주세요.")
          }, actions: {
            ButtonState(role: .none, action: .doneTapped) {
              TextState("확인")
            }
          })
          
          return .none
        
        case .alert(.presented(.doneTapped)):
          state.alert = nil
          
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
