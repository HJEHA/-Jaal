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
  private let onboardingAvatarStore: OnboardingAvatarStore
  private let path: OnboardingRootStore.Path
  
  public init(
    reducer: Reduce<State, Action>,
    onboardingIntroStore: OnboardingIntroStore,
    onboardingProfileStore: OnboardingProfileStore,
    onboardingAvatarStore: OnboardingAvatarStore,
    path: OnboardingRootStore.Path
  ) {
    self.reducer = reducer
    self.onboardingIntroStore = onboardingIntroStore
    self.onboardingProfileStore = onboardingProfileStore
    self.onboardingAvatarStore = onboardingAvatarStore
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
    
    case goToMain
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.intro, action: /Action.intro) {
      onboardingIntroStore
    }
    reducer
      .forEach(\.path, action: /Action.path) {
        Path(
          onboardingProfileStore: onboardingProfileStore,
          onboardingAvatarStore: onboardingAvatarStore
        )
      }
  }
}

extension OnboardingRootStore {
  @Reducer
  public struct Path {
    let onboardingProfileStore: OnboardingProfileStore
    let onboardingAvatarStore: OnboardingAvatarStore
    
    public init(
      onboardingProfileStore: OnboardingProfileStore,
      onboardingAvatarStore: OnboardingAvatarStore
    ) {
      self.onboardingProfileStore = onboardingProfileStore
      self.onboardingAvatarStore = onboardingAvatarStore
    }
    
    @ObservableState
    public enum State: Equatable {
      case profile(OnboardingProfileStore.State)
      case avatar(OnboardingAvatarStore.State)
    }
    
    public enum Action: Equatable {
      case profile(OnboardingProfileStore.Action)
      case avatar(OnboardingAvatarStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
      Scope(state: \.profile, action: \.profile) {
        onboardingProfileStore
      }
      Scope(state: \.avatar, action: \.avatar) {
        onboardingAvatarStore
      }
    }
  }
}
