//
//  CalendarInterface.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/8/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct CalendarStore {
  
  private let reducer: Reduce<State, Action>
  private let day: DayStore
  
  public init(
    reducer: Reduce<State, Action>,
    day: DayStore
  ) {
    self.reducer = reducer
    self.day = day
  }
  
  @ObservableState
  public struct State: Equatable {
    public var isFirstAppear: Bool = false
    public let calendar: Calendar = Calendar.current
    public var monthTitle: String = ""
    
    public var selectedDate: Date = Date()
    public var days: IdentifiedArrayOf<DayStore.State> = []
    
    public var isDayCenter: Bool = false
    public var todayID: UUID = UUID()
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case onAppear
    case changedMonth(Int)
    case selectedDate(Date)
    case selectedToday(Bool)
    
    case day(id: DayStore.State.ID, action: DayStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
      .forEach(\.days, action: /Action.day) {
        day
      }
  }
}
