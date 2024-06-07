//
//  ActivitiesStore.swift
//  FeatureRecord
//
//  Created by 황제하 on 5/2/24.
//

import Foundation
import SwiftData

import ComposableArchitecture

import FeatureRecordInterface
import DomainActivity
import DomainActivityInterface
import SharedUtil

extension ActivitiesStore {
  public init(activityDetail: ActivityDetailStore) {
    
    @Dependency(\.activityClient) var activityClient
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .binding(\.filterIndex):
          return .send(.fetch(state.selectedDate))
        
        case .onAppear:
          return .send(.fetch(state.selectedDate))
          
        case let .fetch(date):
          let date = DateUtil.shared.toYearMonthDay(from: date)
          var predicate: Predicate<Activity>
          if let mode = MeasurementFilter.toMeasurementMode(state.filterIndex) {
            predicate = {
              return #Predicate {
                $0.dateString == date
                && $0.measurementTitle == mode.title
              }
            }()
          } else {
            predicate = {
              return #Predicate {
                $0.dateString == date
              }
            }()
          }
          
          let descriptor: FetchDescriptor<Activity> = .init(
            predicate: predicate,
            sortBy: [
              .init(\.date, order: .reverse)
            ]
          )
          
          do {
            state.activities = try activityClient.fetch(descriptor)
          } catch {
            state.activities = []
          }
          
          return .none
          
        default:
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      activityDetail: activityDetail
    )
  }
}
