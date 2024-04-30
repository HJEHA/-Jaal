//
//  MyPageRootInterface.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

import ComposableArchitecture

import FeatureOnboardingInterface
import DomainActivityInterface
import SharedUtil

@Reducer
public struct MyPageRootStore {
  
  private let reducer: Reduce<State, Action>
  private let calender: CalendarStore
  private let activityDetail: ActivityDetailStore
  private let onboardingProfile: OnboardingProfileStore
  private let onboardingAvatar: OnboardingAvatarStore
  
  public init(
    reducer: Reduce<State, Action>,
    calender: CalendarStore,
    activityDetail: ActivityDetailStore,
    onboardingProfile: OnboardingProfileStore,
    onboardingAvatar: OnboardingAvatarStore
  ) {
    self.reducer = reducer
    self.calender = calender
    self.activityDetail = activityDetail
    self.onboardingProfile = onboardingProfile
    self.onboardingAvatar = onboardingAvatar
  }
  
  @ObservableState
  public struct State: Equatable {
    public var calendar: CalendarStore.State = .init()
    public var filterIndex: Int = 0
    public var selectedDate: Date = .now
    
    public var activities: [Activity] = []
    public var path = StackState<ActivityDetailStore.State>()
    
    @Presents public var onboardingProfile: OnboardingProfileStore.State?
    @Presents public var onboardingAvatar: OnboardingAvatarStore.State?
    
    public var showResetActionSheet: Bool = false
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    
    case appear
    case filterSelected(Int)
    case calendar(CalendarStore.Action)
    case path(
      StackAction<ActivityDetailStore.State, ActivityDetailStore.Action>
    )
    case fetch
    
    case editProfileButtonTapped
    case onboardingProfile(PresentationAction<OnboardingProfileStore.Action>)
    
    case editAvatarButtonTapped
    case onboardingAvatar(PresentationAction<OnboardingAvatarStore.Action>)
    
    case resetButtonTapped
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.calendar, action: /Action.calendar) {
      calender
    }
    reducer
      .forEach(\.path, action: \.path) {
        activityDetail
      }
      .ifLet(\.$onboardingProfile, action: /Action.onboardingProfile) {
        onboardingProfile
      }
      .ifLet(\.$onboardingAvatar, action: /Action.onboardingAvatar) {
        onboardingAvatar
      }
  }
}
