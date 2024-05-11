//
//  MeasurementInterface.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/2/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import SharedDesignSystem

@Reducer
public struct MeasurementStore {
  
  private let reducer: Reduce<State, Action>
  private let faceTracking: FaceTrackingStore
  
  public init(
    reducer: Reduce<State, Action>,
    faceTracking: FaceTrackingStore
  ) {
    self.reducer = reducer
    self.faceTracking = faceTracking
  }
  
  public enum CancelID {
    case timer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var mode: MeasurementMode
    public var title: String

    public var sharedState: FaceTrackingSharedState = .init()
    
    private var _faceTracking: FaceTrackingStore.State = .init()
    public var faceTracking: FaceTrackingStore.State {
      get {
        var subState = self._faceTracking
        subState.sharedState = self.sharedState
        return subState
      }
      
      set {
        self._faceTracking = newValue
        self.sharedState = newValue.sharedState
      }
    }
    
    public var isInitailing: Bool = false
    public var initialTimerCount: Int = 5
    public var initialFaceCenter: SIMD3<Float>?
    
    public var time: Int = 0
    public var correctPoseTime: Int = 0
    public var timeString: String = "00:00"
    
    public var eyeBlinkCount = 0
    
    public var isWarning: Bool = false
    
    public var timeLapseData: [Timelapse] = []
    
    public init(
      title: String,
      mode: MeasurementMode
    ) {
      self.title = title
      self.mode = mode
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    
    case faceTracking(FaceTrackingStore.Action)
    
    case appear
    case initialTimerTicked
    case initialTimerStart
    case start
    case timerTicked
    case faceDistance
    case eyeBlinked
    case saveTimeLapseResponse(Timelapse)
    case closeButtonTapped
    case saveActivity
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.faceTracking, action: /Action.faceTracking) {
      faceTracking
    }
    reducer
  }
}
