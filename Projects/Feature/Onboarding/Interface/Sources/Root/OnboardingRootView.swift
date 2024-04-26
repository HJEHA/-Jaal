//
//  OnboardingRootView.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import SwiftUI

import ComposableArchitecture

public struct OnboardingRootView: View {
  @Bindable private var store: StoreOf<OnboardingRootStore>
  
  public init(store: StoreOf<OnboardingRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack(
      path: $store.scope(
        state: \.path,
        action: \.path
      )
    ) {
      OnboardingIntroView(
        store: store.scope(
          state: \.intro,
          action: \.intro
        )
      )
    } destination: { store in
      switch store.state {
        case .profile:
          if let store = store.scope(
            state: \.profile,
            action: \.profile
          ) {
            OnboardingProfileView(store: store)
          }
        case .avatar:
          if let store = store.scope(
            state: \.avatar,
            action: \.avatar
          ) {
            OnboardingAvatarView(store: store)
          }
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
