//
//  FaceTrackingInterface.swift
//  FeatureMeasurementInterface
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
    public var sharedState: FaceTrackingSharedState = .init()
    
    public var isSnapshot: Bool = false
    
    public init() { }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    
    case snapshot
    case saveImage(UIImage?)
  }
  
  public var body: some Reducer<State, Action> {
    BindingReducer()
    reducer
  }
}
