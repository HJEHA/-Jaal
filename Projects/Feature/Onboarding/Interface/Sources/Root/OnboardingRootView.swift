//
//  OnboardingRootView.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import SwiftUI

import ComposableArchitecture

public struct OnboardingRootView: View {
  private let store: StoreOf<OnboardingRootStore>
  
  public init(store: StoreOf<OnboardingRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    OnboardingIntroView(
      store: store.scope(
        state: \.intro,
        action: \.intro
      )
    )
    .onAppear {
      store.send(.onAppear)
    }
  }
}
