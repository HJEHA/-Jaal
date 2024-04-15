//
//  ActivityDetailInterface.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/15/24.
//

import Foundation

import ComposableArchitecture

import DomainActivityInterface
import SharedUtil

@Reducer
public struct ActivityDetailStore {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var activity: Activity
    
    var navigationBartitle: String {
      return "\(DateUtil.shared.toMonthDay(from: activity.date)) (\(DateUtil.shared.toDayOfWeek(from: activity.date)))"
    }
    var dateRange: String {
      return activity.date.dateRangeString(
        minusSeconds: TimeInterval(activity.activityDuration)
      )
    }
    
    public init(activity: Activity) {
      self.activity = activity
    }
  }
  
  public enum Action: Equatable {
    case onAppear
    case saveButtonTapped
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
