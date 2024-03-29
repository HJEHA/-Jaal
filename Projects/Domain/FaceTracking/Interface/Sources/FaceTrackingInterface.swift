//
//  FaceTrackingInterface.swift
//  DomainFaceTrackingInterface
//
//  Created by 황제하 on 3/29/24.
//

import ComposableArchitecture

public struct FaceTrackingStore: Reducer {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    var faceCenter: SIMD3<Float>?
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case changedFaceCenter(SIMD3<Float>?)
  }
  
  public var body: some Reducer<State, Action> {
    reducer
  }
}
