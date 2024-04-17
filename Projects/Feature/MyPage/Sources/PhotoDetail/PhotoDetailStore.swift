//
//  PhotoDetailStore.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/17/24.
//

import Foundation

import ComposableArchitecture

import FeatureMyPageInterface

extension PhotoDetailStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .none
        case .nextButtonTapped:
          return .none
        case .preButtonTapped:
          return .none
        case .closeButtonTapped:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
