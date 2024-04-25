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
          
        case .intro:
          
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      onboardingIntroStore: OnboardingIntroStore()
    )
  }
}
