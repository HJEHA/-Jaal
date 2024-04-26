//
//  OnboardingProfileInterface.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnboardingProfileStore {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var name: String = ""
    public var placeholder: String = "이름을 입력해주세요"
    
    public var goToAvatarButtonDisabled: Bool {
      return !(name.count > 0 && name.count <= 8)
    }
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case onAppear
    case goToAvatar
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
