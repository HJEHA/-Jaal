//
//  MeasurementInterface.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/2/24.
//

import ComposableArchitecture

import DomainFaceTracking
import DomainFaceTrackingInterface
import SharedDesignSystem

@Reducer
public struct MeasurementStore {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public enum CancelID {
    case timer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var faceTracking: FaceTrackingStore.State = .init()
    public var brightness: BrightnessStore.State = .init()
    
    public var isInitailing: Bool = false
    public var initialTimerCount: Int = 5
    public var initialFaceCenter: SIMD3<Float>?
    
    public var time: Int = 0
    public var timeString: String = "00:00"
    
    public var isEyeClose = false
    public var eyeBlinkCount = 0
    
    public var faceCenter: SIMD3<Float>?
    public var isWarning: Bool = false
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case faceTracking(FaceTrackingStore.Action)
    case brightness(BrightnessStore.Action)
    
    case appear
    
    case initialTimerTicked
    case initialTimerStart
    
    case start
    case timerTicked
    case closeButtonTapped
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.faceTracking, action: /Action.faceTracking) {
      FaceTrackingStore()
    }
    Scope(state: \.brightness, action: /Action.brightness) {
      BrightnessStore()
    }
    reducer
  }
}
