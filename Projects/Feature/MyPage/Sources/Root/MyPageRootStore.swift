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
          
        case .editProfileButtonTapped:
          state.onboardingProfile = .init(
            name: KUUserDefaults.name,
            isEdit: true
          )
          return .none
        
        case .editAvatarButtonTapped:
          state.onboardingAvatar = .init(
            skinID: KUUserDefaults.skinID,
            headID: KUUserDefaults.headID,
            faceID: KUUserDefaults.faceID,
            isEdit: true
          )
          return .none
          
        case .onboardingProfile(.presented(.doneButtonTapped)):
          KUUserDefaults.name = state.onboardingProfile?.name ?? ""
          state.onboardingProfile = nil
          return .none
          
        case .onboardingAvatar(.presented(.doneButtonTapped)):
          KUUserDefaults.skinID = state.onboardingAvatar?.skinID ?? 0
          KUUserDefaults.headID = state.onboardingAvatar?.headID ?? 0
          KUUserDefaults.faceID = state.onboardingAvatar?.faceID ?? 0
          state.onboardingAvatar = nil
          return .none
          
        case .resetButtonTapped:
          KUUserDefaults.reset()
          
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
