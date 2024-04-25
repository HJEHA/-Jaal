//
//  OnboardingIntroInterface.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnboardingIntroStore {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var tabViewIndex: Int = 0
    
    public var nextButtonText: String {
      return tabViewIndex == 2 ? "프로필 설정" : "다음"
    }
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case onAppear
    case nextButtonTapped
    case goToProfile
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
