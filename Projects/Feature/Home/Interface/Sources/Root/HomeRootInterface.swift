//
//  HomeRootInterface.swift
//  FeatureHomeInterface
//
//  Created by 황제하 on 4/24/24.
//

import Foundation

import ComposableArchitecture

import FeatureMyPageInterface
import DomainActivityInterface

@Reducer
public struct HomeRootStore {
  
  private let reducer: Reduce<State, Action>
  private let activities: ActivitiesStore
  
  public init(
    reducer: Reduce<State, Action>,
    activities: ActivitiesStore
  ) {
    self.reducer = reducer
    self.activities = activities
  }
  
  @ObservableState
  public struct State: Equatable {
    public var activities: ActivitiesStore.State = .init(selectedDate: .now)
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    
    case onAppear
    case activities(ActivitiesStore.Action)
    case activityMoreButtonTapped
    case goToMeamentsureButtonTapped
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.activities, action: /Action.activities) {
      activities
    }
    reducer
  }
}
