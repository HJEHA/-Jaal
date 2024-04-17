//
//  FaceTrackingInterface.swift
//  DomainFaceTrackingInterface
//
//  Created by 황제하 on 3/29/24.
//

import SwiftUI

import ComposableArchitecture

@Reducer
public struct FaceTrackingStore {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var faceCenter: SIMD3<Float>?
    public var eyeBlink: Float = 0
    
    public var isSnapshot: Bool = false
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case changedFaceCenter(SIMD3<Float>?)
    case eyeBlink(Float)
    case snapshot
    case saveImage(UIImage?)
  }
  
  public var body: some Reducer<State, Action> {
    reducer
  }
}
