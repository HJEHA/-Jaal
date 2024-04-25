//
//  OnboardingRootInterface.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnboardingRootStore {
  
  private let reducer: Reduce<State, Action>
  private let onboardingIntroStore: OnboardingIntroStore
  
  public init(
    reducer: Reduce<State, Action>,
    onboardingIntroStore: OnboardingIntroStore
  ) {
    self.reducer = reducer
    self.onboardingIntroStore = onboardingIntroStore
  }
  
  @ObservableState
  public struct State: Equatable {
    public var intro: OnboardingIntroStore.State = .init()
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case onAppear
    
    case intro(OnboardingIntroStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.intro, action: /Action.intro) {
      onboardingIntroStore
    }
    reducer
  }
}
