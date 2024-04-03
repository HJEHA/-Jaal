//
//  MeasurementInterface.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/2/24.
//

import ComposableArchitecture

import DomainFaceTracking
import DomainFaceTrackingInterface

@Reducer
public struct MeasurementStore {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var faceTracking: FaceTrackingStore.State = .init()
    
    public var initialFaceCenter: SIMD3<Float>?
    public var faceCenter: SIMD3<Float>?
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case faceTracking(FaceTrackingStore.Action)
    
    case closeButtonTapped
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.faceTracking, action: /Action.faceTracking) {
      FaceTrackingStore()
    }
    reducer
  }
}
