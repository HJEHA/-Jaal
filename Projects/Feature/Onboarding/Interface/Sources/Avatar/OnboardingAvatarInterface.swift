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
    public var isEdit: Bool = false
    
    public init(
      skinID: Int = 0,
      headID: Int = 0,
      faceID: Int = 0,
      isEdit: Bool = false
    ) {
      self.skinID = skinID
      self.headID = headID
      self.faceID = faceID
      self.isEdit = isEdit
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case onAppear
    case doneButtonTapped
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
