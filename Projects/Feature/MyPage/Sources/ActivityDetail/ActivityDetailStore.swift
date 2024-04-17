//
//  ActivityDetailStore.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/15/24.
//

import Foundation

import ComposableArchitecture

import FeatureMyPageInterface
import DomainActivityInterface

extension ActivityDetailStore {
  public init() {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .none
          
        case .saveButtonTapped:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
