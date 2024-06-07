//
//  MainTabStore.swift
//  Feature
//
//  Created by 황제하 on 3/29/24.
//

import Foundation

import ComposableArchitecture

import FeatureHome
import FeatureHomeInterface
import FeatureMeasurement
import FeatureMeasurementInterface
import FeatureRecord
import FeatureRecordInterface
import FeatureOnboarding
import FeatureOnboardingInterface

@Reducer
public struct MainTabStore {
  public init() { }
  
  @ObservableState
  public struct State: Equatable {
    public var home: HomeRootStore.State = .init()
    public var measurement: MeasurementRootStore.State = .init()
    public var myPage: RecordRootStore.State = .init()
    
    public var selection: Int = 0
    public var newActivityBadge: String? = nil
    public init() {}
  }
  
  public enum Action: Equatable {
    case home(HomeRootStore.Action)
    case measurement(MeasurementRootStore.Action)
    case myPage(RecordRootStore.Action)
    
    case selectionChanged(Int)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.home, action: /Action.home) {
      HomeRootStore(
        onboardingProfile: OnboardingProfileStore(), 
        onboardingAvatar: OnboardingAvatarStore(),
        activities: ActivitiesStore(
          activityDetail: ActivityDetailStore()
        )
      )
    }
    Scope(state: \.measurement, action: /Action.measurement) {
      MeasurementRootStore()
    }
    Scope(state: \.myPage, action: /Action.myPage) {
      RecordRootStore()
    }
    Reduce { state, action in
      switch action {
        case .home(.activityMoreButtonTapped):
          state.selection = 2
          return .none
          
        case .home(.goToMeamentsureButtonTapped):
          state.selection = 1
          return .none
          
        case .measurement(.measurement(.presented(.saveActivity))):
          state.newActivityBadge = "New"
          return .none
          
        case let .selectionChanged(selection):
          state.selection = selection
          return .none
          
        case .myPage(.onAppear):
          if state.newActivityBadge != nil {
            state.newActivityBadge = nil
            return .send(.myPage(.calendar(.selectedDate(.now))))
          }
          
          return .none
          
        default:
          return .none
      }
    }
  }
}
