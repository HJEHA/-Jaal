//
//  OnboardingProfileStore.swift
//  FeatureOnboarding
//
//  Created by 황제하 on 4/25/24.
//

import Foundation

import ComposableArchitecture

import FeatureOnboardingInterface
import CoreUserDefaults

extension OnboardingProfileStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .binding:
          return .none
          
        case .onAppear:
          return .none
          
        case .goToAvatar:
          JaalUserDefaults.name = state.name
          print(JaalUserDefaults.name)
          
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
