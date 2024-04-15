//
//  MyPageRootInterface.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

import ComposableArchitecture

import DomainActivityInterface
import SharedUtil

@Reducer
public struct MyPageRootStore {
  
  private let reducer: Reduce<State, Action>
  private let calender: CalendarStore
  private let activityDetail: ActivityDetailStore
  
  public init(
    reducer: Reduce<State, Action>,
    calender: CalendarStore,
    activityDetail: ActivityDetailStore
  ) {
    self.reducer = reducer
    self.calender = calender
    self.activityDetail = activityDetail
  }
  
  @ObservableState
  public struct State: Equatable {
    public var calendar: CalendarStore.State = .init()
    public var filterIndex: Int = 0
    public var selectedDate: Date = .now
    
    public var activities: [Activity] = []
    public var path = StackState<ActivityDetailStore.State>()
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case appear
    case filterSelected(Int)
    case calendar(CalendarStore.Action)
    case path(
      StackAction<ActivityDetailStore.State, ActivityDetailStore.Action>
    )
    case fetch
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.calendar, action: /Action.calendar) {
      calender
    }
    reducer
      .forEach(\.path, action: \.path) {
        activityDetail
      }
  }
}
