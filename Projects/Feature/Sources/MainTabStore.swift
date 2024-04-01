//
//  MainTabStore.swift
//  Feature
//
//  Created by 황제하 on 3/29/24.
//

import Foundation

import ComposableArchitecture

public struct MainTabStore: Reducer {
  public init() { }
  
  public struct State: Equatable {
    public var currentScene: MainScene = .home
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case selectTab(MainScene)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case let .selectTab(scene):
          state.currentScene = scene
          return .none
      }
    }
  }
}
