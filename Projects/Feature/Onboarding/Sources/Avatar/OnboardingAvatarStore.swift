//
//  OnboardingAvatarStore.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/26/24.
//

import Foundation

import ComposableArchitecture

import FeatureOnboardingInterface
import CoreUserDefaults
import SharedDesignSystem

extension OnboardingAvatarStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .binding:
          return .none
          
        case .onAppear:
          state.isScrollCenter = true
          
          return .none
          
        case .shuffleButtonTapped:
          state.skinID = Int.random(in: SkinColors.allCases.indices)
          state.headID = Int.random(in: Heads.allCases.indices)
          state.faceID = Int.random(in: Faces.allCases.indices)
          
          state.isScrollCenter = true
          
          return .none
          
        case .doneButtonTapped:
          JaalUserDefaults.skinID = state.skinID
          JaalUserDefaults.headID = state.headID
          JaalUserDefaults.faceID = state.faceID
          JaalUserDefaults.isOnboarding = false
          
          return .none
      }
      
    }
    
    self.init(reducer: reducer)
  }
}
