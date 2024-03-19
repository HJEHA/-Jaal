import Foundation

import ComposableArchitecture

public struct RootStore: ReducerProtocol {
  
  public enum State: Equatable {
    case onAppear(Bool)
    
    public init() {
      self = .onAppear(true)
    }
  }
  
  public enum Action: Equatable {
    
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
          
        default:
          return .none
          
      }
    }
  }
}
