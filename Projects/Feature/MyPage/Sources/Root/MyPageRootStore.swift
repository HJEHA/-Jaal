//
//  MyPageRootStore.swift
//  FeatureMyPage
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

import ComposableArchitecture

import FeatureMyPageInterface
import DomainActivity
import DomainActivityInterface

extension MyPageRootStore {
  public init() {
    @Dependency(\.activityClient) var activityClient
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .appear:
          do {
            let test = try activityClient.fetchAll()
            test.map {
              print($0.blinkCount)
            }
          } catch { }
          
          return .none
          
        case let .filterSelected(index):
          state.filterIndex = index
          
          return .none
          
        case let .calendar(action):
          return .none
      }
    }
    
    self.init(reducer: reducer, calender: CalendarStore())
  }
}
