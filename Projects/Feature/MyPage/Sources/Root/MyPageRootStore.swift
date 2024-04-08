//
//  MyPageRootStore.swift
//  FeatureMyPage
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

import ComposableArchitecture

import FeatureMyPageInterface

extension MyPageRootStore {
  public init() {
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case let .calendar(action):
          print(action)
          return .none
      }
    }
    
    self.init(reducer: reducer, calender: CalendarStore())
  }
}
