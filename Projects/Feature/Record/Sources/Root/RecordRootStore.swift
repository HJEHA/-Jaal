//
//  RecordRootStore.swift
//  FeatureRecord
//
//  Created by 황제하 on 4/9/24.
//

import Foundation
import SwiftData

import ComposableArchitecture

import FeatureRecordInterface
import CoreUserDefaults
import SharedUtil

extension RecordRootStore {
  public init() {
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .none
          
        case let .calendar(.selectedDate(date)):
          state.selectedDate = date
          state.activities.selectedDate = date
          return .send(.activities(.fetch(date)))
          
        default:
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      calender: CalendarStore(),
      activities: ActivitiesStore(
        activityDetail: ActivityDetailStore()
      )
    )
  }
}
