//
//  HomeRootStore.swift
//  FeatureHome
//
//  Created by 황제하 on 4/24/24.
//

import Foundation
import SwiftData

import ComposableArchitecture

import FeatureHomeInterface
import DomainActivity
import DomainActivityInterface
import SharedUtil

extension HomeRootStore {
  public init() {
    
    @Dependency(\.activityClient) var activityClient
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          let date = DateUtil.shared.toYearMonthDay(from: .now)
          let predicate: Predicate<Activity> = {
            return #Predicate {
              $0.dateString == date
            }
          }()
          
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
      }
    }
    
    self.init(reducer: reducer)
  }
}
