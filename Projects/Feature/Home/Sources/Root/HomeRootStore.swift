//
//  HomeRootStore.swift
//  FeatureHome
//
//  Created by 황제하 on 4/24/24.
//

import Foundation
import SwiftData

import ComposableArchitecture

import FeatureHomeInterface
import FeatureOnboardingInterface
import FeatureRecordInterface
import DomainActivity
import DomainActivityInterface
import CoreUserDefaults
import SharedUtil

extension HomeRootStore {
  public init(
    onboardingProfile: OnboardingProfileStore,
    onboardingAvatar: OnboardingAvatarStore,
    activities: ActivitiesStore
  ) {
    
    @Dependency(\.activityClient) var activityClient
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .run { send in
            await send(.activities(.fetch(.now)))
          }
          
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
      onboardingProfile: onboardingProfile,
      onboardingAvatar: onboardingAvatar,
      activities: activities
    )
  }
}
