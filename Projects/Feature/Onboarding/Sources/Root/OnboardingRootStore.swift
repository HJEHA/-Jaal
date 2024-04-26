//
//  OnboardingRootStore.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import Foundation

import ComposableArchitecture

import FeatureOnboardingInterface

extension OnboardingRootStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .none
          
        case let .path(action):
          switch action {
            case .element(id: _, action: .profile(.goToAvatar)):
              return .none
            
            default:
              return .none
          }
          
        case .intro(.goToProfile):
          state.path.append(.profile(.init()))
          return .none
          
        default:
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      onboardingIntroStore: OnboardingIntroStore(),
      onboardingProfileStore: OnboardingProfileStore(),
      path: Path(
        onboardingProfileStore: OnboardingProfileStore()
      )
    )
  }
}
