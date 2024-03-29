import Foundation

import ComposableArchitecture

import DomainFaceTrackingInterface

public struct RootStore: Reducer {
  
  public struct State: Equatable {
    var faceTracking: FaceTrackingStore.State
  }
  
  public enum Action: Equatable {
    case faceTracking(FaceTrackingStore.Action)
  }
  
  public var body: some Reducer<State, Action> {
    
    Reduce { state, action in
      switch action {
        case let .faceTracking(action):
          print(action)
          return .none
      }
    }
  }
}
