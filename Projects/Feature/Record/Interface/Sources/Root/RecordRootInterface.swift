//
//  RecordRootInterface.swift
//  FeatureRecordInterface
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

import ComposableArchitecture

import DomainActivityInterface
import SharedUtil

@Reducer
public struct RecordRootStore {
  
  private let reducer: Reduce<State, Action>
  private let calender: CalendarStore
  private let activities: ActivitiesStore
  
  public init(
    reducer: Reduce<State, Action>,
    calender: CalendarStore,
    activities: ActivitiesStore
  ) {
    self.reducer = reducer
    self.calender = calender
    self.activities = activities
  }
  
  @ObservableState
  public struct State: Equatable {
    public var calendar: CalendarStore.State = .init()
    public var activities: ActivitiesStore.State = .init(selectedDate: .now)
    public var selectedDate: Date = .now
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    
    case onAppear
    case calendar(CalendarStore.Action)
    case activities(ActivitiesStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.calendar, action: /Action.calendar) {
      calender
    }
    Scope(state: \.activities, action: /Action.activities) {
      activities
    }
    reducer
  }
}
