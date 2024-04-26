import SwiftUI

import ComposableArchitecture

import Feature
import FeatureOnboarding
import FeatureOnboardingInterface

struct RootView: View {
  public let store: StoreOf<RootStore>
  
  public init(store: StoreOf<RootStore>) {
    self.store = store
  }
  
  var body: some View {
    switch store.state {
      case .onboarding:
        if let store = store.scope(
          state: \.onboarding,
          action: \.onboarding
        ) {
          OnboardingRootView(store: store)
        }
      case .mainTab:
        if let store = store.scope(
          state: \.mainTab,
          action: \.mainTab
        ) {
          MainTabView(store: store)
        }
    }
  }
}
