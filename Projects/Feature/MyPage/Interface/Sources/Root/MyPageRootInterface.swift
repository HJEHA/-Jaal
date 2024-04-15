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
  
  public init(reducer: Reduce<State, Action>, calender: CalendarStore) {
    self.reducer = reducer
    self.calender = calender
  }
  
  @ObservableState
  public struct State: Equatable {
    public var calendar: CalendarStore.State = .init()
    public var filterIndex: Int = 0
    public var selectedDate: Date = .now
    
    public var activities: [Activity] = []
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case appear
    case filterSelected(Int)
    case calendar(CalendarStore.Action)
    case fetch
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.calendar, action: /Action.calendar) {
      calender
    }
    reducer
  }
}
