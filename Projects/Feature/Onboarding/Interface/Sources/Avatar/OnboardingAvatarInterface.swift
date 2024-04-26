//
//  OnboardingAvatarInterface.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/26/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnboardingAvatarStore {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var skinID: Int = 0
    public var headID: Int = 0
    public var faceID: Int = 0
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case onAppear
    case doneButtonTapped
    case goToMain
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
