//
//  ActivitiesInterface.swift
//  FeatureRecordInterface
//
//  Created by 황제하 on 5/2/24.
//

import Foundation

import ComposableArchitecture

import DomainActivityInterface

@Reducer
public struct ActivitiesStore {
  
  private let reducer: Reduce<State, Action>
  private let activityDetail: ActivityDetailStore
  
  public init(
    reducer: Reduce<State, Action>,
    activityDetail: ActivityDetailStore
  ) {
    self.reducer = reducer
    self.activityDetail = activityDetail
  }
  
  @ObservableState
  public struct State: Equatable {
    public var filterIndex: Int = 0
    public var selectedDate: Date = .now
    public var activities: [Activity] = []
    public var path = StackState<ActivityDetailStore.State>()
    
    public init(selectedDate: Date = .now) {
      self.selectedDate = selectedDate
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    
    case onAppear
    case fetch(Date)
    
    case path(
      StackAction<ActivityDetailStore.State, ActivityDetailStore.Action>
    )
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .forEach(\.path, action: \.path) {
        activityDetail
      }
  }
}
