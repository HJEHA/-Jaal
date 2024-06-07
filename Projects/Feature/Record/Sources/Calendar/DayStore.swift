//
//  DayStore.swift
//  FeatureRecordInterface
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

import ComposableArchitecture

import FeatureRecordInterface
import SharedUtil

extension DayStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          state.day = DateUtil.shared.toDayOfWeek(from: state.date)
          state.dayNumber = DateUtil.shared.day(
            calendar: state.calendar,
            from: state.date
          )
          
          return .none
          
        case .selected:
          
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
