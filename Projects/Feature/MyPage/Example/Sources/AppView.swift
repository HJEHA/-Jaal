import SwiftUI

import FeatureMyPage
import FeatureMyPageInterface
import FeatureOnboarding
import FeatureOnboardingInterface

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      MyPageRootView(
        store: .init(initialState: MyPageRootStore.State()) {
          MyPageRootStore(
            onboardingProfile: OnboardingProfileStore(),
            onboardingAvatar: OnboardingAvatarStore()
          )
        }
      )
    }
  }
}

