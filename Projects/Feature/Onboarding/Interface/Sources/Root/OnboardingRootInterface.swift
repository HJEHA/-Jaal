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
  private let onboardingProfileStore: OnboardingProfileStore
  private let path: OnboardingRootStore.Path
  
  public init(
    reducer: Reduce<State, Action>,
    onboardingIntroStore: OnboardingIntroStore,
    onboardingProfileStore: OnboardingProfileStore,
    path: OnboardingRootStore.Path
  ) {
    self.reducer = reducer
    self.onboardingIntroStore = onboardingIntroStore
    self.onboardingProfileStore = onboardingProfileStore
    self.path = path
  }
  
  @ObservableState
  public struct State: Equatable {
    public var path = StackState<Path.State>()
    public var intro: OnboardingIntroStore.State = .init()
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case onAppear
    case intro(OnboardingIntroStore.Action)
    
    case path(StackAction<Path.State, Path.Action>)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.intro, action: /Action.intro) {
      onboardingIntroStore
    }
    reducer
      .forEach(\.path, action: /Action.path) {
        Path(onboardingProfileStore: onboardingProfileStore)
      }
  }
}

extension OnboardingRootStore {
  @Reducer
  public struct Path {
    let onboardingProfileStore: OnboardingProfileStore
    
    public init(
      onboardingProfileStore: OnboardingProfileStore
    ) {
      self.onboardingProfileStore = onboardingProfileStore
    }
    
    @ObservableState
    public enum State: Equatable {
      case profile(OnboardingProfileStore.State)
    }
    
    public enum Action: Equatable {
      case profile(OnboardingProfileStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
      Scope(state: \.profile, action: \.profile) {
        onboardingProfileStore
      }
    }
  }
}
