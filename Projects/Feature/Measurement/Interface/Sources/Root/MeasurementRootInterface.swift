//
//  MeasurementRootInterface.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/01/24.
//

import Foundation

import ComposableArchitecture

import DomainActivityInterface
import CoreUserDefaults

@Reducer
public struct MeasurementRootStore {

  private let reducer: Reduce<State, Action>
  private let measurement: MeasurementStore
  
  public init(
    reducer: Reduce<State, Action>,
    measurement: MeasurementStore
  ) {
    self.reducer = reducer
    self.measurement = measurement
  }
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var measurement: MeasurementStore.State?
    
    public var title: String = ""
    public var placeholder: String = "이전 제목 (\(JaalUserDefaults.lastMeasurementTitle))"
    public var selectedMode: MeasurementMode = .normal
    
    public var selectedTimerPickerItem: Int = JaalUserDefaults.timerValue
    public var selectedDrowsinessTimerPickerItem: Int = JaalUserDefaults.drowsinessTimerValue
    public var timerPickerItems: [Int] = [
    5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60
    ]
    public var isSaveTimeLapse: Bool = JaalUserDefaults.isSaveTimeLapse
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    
    case measurement(PresentationAction<MeasurementStore.Action>)
    
    case onAppear
    case modeButtonTapped(MeasurementMode)
    case startButtonTapped
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .ifLet(\.$measurement, action: /Action.measurement) {
        measurement
      }
  }
}
