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
      if JaalUserDefaults.isOnboarding == true {
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
    Scope(state: \.mainTab, action: /Action.mainTab) {
      MainTabStore()
    }
    Scope(state: \.onboarding, action: /Action.onboarding) {
      OnboardingRootStore()
    }
    Reduce { state, action in
      switch action {
        case .mainTab:
          return .none
          
        case .onboarding:
          return .none
      }
    }
  }
}
