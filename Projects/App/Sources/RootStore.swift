import Foundation

import ComposableArchitecture

import Feature
import FeatureOnboarding
import FeatureOnboardingInterface
import CoreUserDefaults

@Reducer
public struct RootStore {
  
  @ObservableState
  public enum State: Equatable {
    case onboarding(OnboardingRootStore.State)
    case mainTab(MainTabStore.State)
    
    public init() {
      if KUUserDefaults.isOnboarding == true {
        self = .onboarding(.init())
      } else {
        self = .mainTab(.init())
      }
    }
  }
  
  public enum Action: Equatable {
    case mainTab(MainTabStore.Action)
    case onboarding(OnboardingRootStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case .mainTab(.myPage(.resetButtonTapped)):
          state = .onboarding(.init())
          return .none
          
        case .onboarding(.goToMain):
          state = .mainTab(.init())
          return .none
          
        default:
          return .none
      }
    }
    .ifCaseLet(/State.onboarding, action: /Action.onboarding) {
      OnboardingRootStore()
    }
    .ifCaseLet(/State.mainTab, action: /Action.mainTab) {
      MainTabStore()
    }
  }
}
