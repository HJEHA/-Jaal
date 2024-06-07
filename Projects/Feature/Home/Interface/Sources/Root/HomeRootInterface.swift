//
//  HomeRootInterface.swift
//  FeatureHomeInterface
//
//  Created by 황제하 on 4/24/24.
//

import Foundation

import ComposableArchitecture

import FeatureOnboardingInterface
import FeatureRecordInterface
import DomainActivityInterface

@Reducer
public struct HomeRootStore {
  
  private let reducer: Reduce<State, Action>
  private let onboardingProfile: OnboardingProfileStore
  private let onboardingAvatar: OnboardingAvatarStore
  private let activities: ActivitiesStore
  
  public init(
    reducer: Reduce<State, Action>,
    onboardingProfile: OnboardingProfileStore,
    onboardingAvatar: OnboardingAvatarStore,
    activities: ActivitiesStore
  ) {
    self.reducer = reducer
    self.onboardingProfile = onboardingProfile
    self.onboardingAvatar = onboardingAvatar
    self.activities = activities
  }
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var onboardingProfile: OnboardingProfileStore.State?
    @Presents public var onboardingAvatar: OnboardingAvatarStore.State?
    public var showResetActionSheet: Bool = false
    
    public var activities: ActivitiesStore.State = .init(selectedDate: .now)
    
    public var showTip1: Bool = false
    public var showTip2: Bool = false
    public var showTip3: Bool = false
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    
    case editProfileButtonTapped
    case onboardingProfile(PresentationAction<OnboardingProfileStore.Action>)
    
    case editAvatarButtonTapped
    case onboardingAvatar(PresentationAction<OnboardingAvatarStore.Action>)
    
    case resetButtonTapped
    
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
      .ifLet(\.$onboardingProfile, action: /Action.onboardingProfile) {
        onboardingProfile
      }
      .ifLet(\.$onboardingAvatar, action: /Action.onboardingAvatar) {
        onboardingAvatar
      }
  }
}
