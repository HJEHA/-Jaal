//
//  MyPageRootStore.swift
//  FeatureMyPage
//
//  Created by 황제하 on 4/9/24.
//

import Foundation
import SwiftData

import ComposableArchitecture

import FeatureMyPageInterface
import FeatureOnboardingInterface
import DomainActivity
import DomainActivityInterface
import CoreUserDefaults
import SharedUtil

extension MyPageRootStore {
  public init(
    onboardingProfile: OnboardingProfileStore,
    onboardingAvatar: OnboardingAvatarStore
  ) {
    @Dependency(\.activityClient) var activityClient
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .none
          
        case let .calendar(.selectedDate(date)):
          state.selectedDate = date
          state.activities.selectedDate = date
          return .send(.activities(.fetch(date)))
          
        case .activities:
          return .none
          
        case .editProfileButtonTapped:
          state.onboardingProfile = .init(
            name: JaalUserDefaults.name,
            isEdit: true
          )
          return .none
        
        case .editAvatarButtonTapped:
          state.onboardingAvatar = .init(
            skinID: JaalUserDefaults.skinID,
            headID: JaalUserDefaults.headID,
            faceID: JaalUserDefaults.faceID,
            isEdit: true
          )
          return .none
          
        case .onboardingProfile(.presented(.doneButtonTapped)):
          JaalUserDefaults.name = state.onboardingProfile?.name ?? ""
          state.onboardingProfile = nil
          return .none
          
        case .onboardingAvatar(.presented(.doneButtonTapped)):
          JaalUserDefaults.skinID = state.onboardingAvatar?.skinID ?? 0
          JaalUserDefaults.headID = state.onboardingAvatar?.headID ?? 0
          JaalUserDefaults.faceID = state.onboardingAvatar?.faceID ?? 0
          state.onboardingAvatar = nil
          return .none
          
        case .resetButtonTapped:
          JaalUserDefaults.isOnboarding = true
          JaalUserDefaults.name = ""
          JaalUserDefaults.skinID = 0
          JaalUserDefaults.headID = 0
          JaalUserDefaults.faceID = 0
          
          try? activityClient.deleteAll()
          
          return .none
          
        default:
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      calender: CalendarStore(),
      activities: ActivitiesStore(
        activityDetail: ActivityDetailStore()
      ),
      onboardingProfile: onboardingProfile,
      onboardingAvatar: onboardingAvatar
    )
  }
}
