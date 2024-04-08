//
//  DayStore.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

import ComposableArchitecture

import FeatureMyPageInterface

extension DayStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          state.day = DayStore.dayOfWeek(state: &state)
          state.dayNumber = DayStore.day(state: &state)
          
          return .none
          
        case .selected:
          
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}

extension DayStore {
  static func dayOfWeek(state: inout State) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("E")
    return dateFormatter.string(from: state.date)
  }
  
  static func day(state: inout State) -> String {
    return "\(state.calendar.component(.day, from: state.date))"
  }
}

