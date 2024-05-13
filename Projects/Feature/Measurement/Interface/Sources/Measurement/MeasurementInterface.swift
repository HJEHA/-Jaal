//
//  MeasurementInterface.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/2/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import CoreUserDefaults
import SharedUtil

@Reducer
public struct MeasurementStore {
  
  private let reducer: Reduce<State, Action>
  private let faceTracking: FaceTrackingStore
  private let measurementStart: MeasurementStartStore
  
  public init(
    reducer: Reduce<State, Action>,
    faceTracking: FaceTrackingStore,
    measurementStart: MeasurementStartStore
  ) {
    self.reducer = reducer
    self.faceTracking = faceTracking
    self.measurementStart = measurementStart
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
    public var measurementStart: MeasurementStartStore.State?
    
    public var initialFaceCenter: SIMD3<Float>?
    public var time: Int = 0
    public var correctPoseTime: Int = 0
    public var timeString: String {
      switch mode {
        case .normal:
          return TimeFormatter.toClockString(from: time)
        case .focus:
          let totalTime = JaalUserDefaults.timerValue * 60
          
          return TimeFormatter.toClockString(from: totalTime - time)
      }
    }
    
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
    case measurementStart(MeasurementStartStore.Action)
    
    case onAppear
    case start
    case timerTicked
    case faceDistance
    case eyeBlinked
    case saveTimeLapseResponse(Timelapse)
    case closeButtonTapped
    case saveActivity
    case saveActivityCompleted(Activity)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Scope(state: \.faceTracking, action: \.faceTracking) {
      faceTracking
    }
    reducer
      .ifLet(\.measurementStart, action: \.measurementStart) {
        measurementStart
      }
  }
}
