import SwiftUI

import FeatureOnboarding
import FeatureOnboardingInterface

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      OnboardingRootView(
        store: .init(initialState: OnboardingRootStore.State()) {
          OnboardingRootStore()
        }
      )
    }
  }
}

