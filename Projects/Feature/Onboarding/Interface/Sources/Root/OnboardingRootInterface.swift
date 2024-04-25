//
//  OnboardingRootInterface.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import Foundation

import ComposableArchitecture

import DomainActivityInterface

@Reducer
public struct OnboardingRootStore {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var activities: [Activity] = []
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case onAppear
  }
  
  public var boday: some ReducerOf<Self> {
    reducer
  }
}
