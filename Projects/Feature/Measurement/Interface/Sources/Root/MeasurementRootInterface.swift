//
//  MeasurementRootInterface.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/01/24.
//

import Foundation

import ComposableArchitecture

import DomainActivityInterface

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
    public var placeholder: String = "제목을 입력해주세요"
    public var selectedMode: MeasurementMode = .normal
    
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
