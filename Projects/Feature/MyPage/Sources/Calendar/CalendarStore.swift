//
//  CalendarStore.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/8/24.
//

import Foundation

import ComposableArchitecture

import FeatureMyPageInterface

extension CalendarStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          state.monthTitle = CalendarStore.monthTitle(from: state.selectedDate)
          state.days = CalendarStore.days(state: &state)
          
          return .send(.selectedToday(true))
          
        case let .changedMonth(value):
          
          return CalendarStore.changeMonth(value, state: &state)
          
        case let .selectedDate(date):
          state.selectedDate = date
          state.monthTitle = CalendarStore.monthTitle(from: date)
          state.days = CalendarStore.days(state: &state)
          
          return .none
          
        case let .selectedToday(isSelected):
          state.isDayCenter = isSelected
          
          if isSelected == true {
            return .send(.selectedDate(.now))
          }
          
          return .none
          
        case let .day(id: _, action: action):
          switch action {
            case let .selected(date):
              return .send(.selectedDate(date))
            default:
              return .none
          }
      }
    }
    
    self.init(reducer: reducer)
  }
}

extension CalendarStore {
  static func changeMonth(_ value: Int, state: inout State) -> Effect<Action> {
    guard let date = state.calendar.date(
      byAdding: .month,
      value: value,
      to: state.selectedDate
    ) else {
      return .none
    }
    
    return .send(.selectedDate(date))
  }
  
  static func monthTitle(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("yyyy MM")
    return dateFormatter.string(from: date)
  }
  
  static func days(state: inout State) -> IdentifiedArrayOf<DayStore.State> {
    let startDate = state.calendar.date(
      from: Calendar.current.dateComponents(
        [.year, .month],
        from: state.selectedDate
      )
    )!
    
    let components = (0..<state.calendar.range(
      of: .day, in: .month, for: startDate
    )!.count)
      .map {
        state.calendar.date(
          byAdding: .day,
          value: $0,
          to: startDate
        )!
      }
    
    var result = IdentifiedArrayOf<DayStore.State>()
    
    components.forEach {
      let isSelected = state.calendar.isDate(
        state.selectedDate,
        equalTo: $0,
        toGranularity: .day
      )
      
      let day = DayStore.State(date: $0, isSelected: isSelected)
      
      let isToday = state.calendar.isDate(
        .now,
        equalTo: $0,
        toGranularity: .day
      )
      
      if isToday == true {
        state.todayID = day.id
      }
      
      result.append(day)
    }
    
    return result
  }
}
