//
//  HomeRootStore.swift
//  FeatureHome
//
//  Created by 황제하 on 4/24/24.
//

import Foundation
import SwiftData

import ComposableArchitecture

import FeatureHomeInterface
import FeatureMyPageInterface
import SharedUtil

extension HomeRootStore {
  public init(
    activities: ActivitiesStore
  ) {
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case .onAppear:
          return .run { send in
            await send(.activities(.fetch(.now)))
          }
          
        case .binding:
          return .none
        
        default:
          return .none
      }
    }
    
    self.init(
      reducer: reducer,
      activities: activities
    )
  }
}
