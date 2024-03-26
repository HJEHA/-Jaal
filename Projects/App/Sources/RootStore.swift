import Foundation

import ComposableArchitecture

public struct RootStore: Reducer {
  
  public struct State: Equatable {
    
  }
  
  public enum Action: Equatable {
    
  }
  
  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
          
        default:
          return .none
          
      }
    }
  }
}
