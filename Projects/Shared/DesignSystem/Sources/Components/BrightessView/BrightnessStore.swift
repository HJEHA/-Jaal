//
//  BrightnessStore.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/8/24.
//

import UIKit

import ComposableArchitecture

@Reducer
public struct BrightnessStore {
  public init() { }
  
  @Dependency(\.continuousClock) var clock
  
  public enum CancelID {
    case timer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var brightness: CGFloat = UIScreen.main.brightness
    public var height: CGFloat = UIScreen.main.brightness * 140
    
    public var isDrag: Bool = false
    public var dragOffset: CGFloat = 0
    
    public var hideTime: Int = 3
    
    public init() { }
  }
  
  public enum Action: Equatable {
    case dragged(Double)
    case dragEnd
    
    case timerTicked
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        case let .dragged(translation):
          state.isDrag = true
          state.hideTime = 3
          
          state.dragOffset += translation
          state.brightness += (state.dragOffset * -0.0005)
          state.dragOffset = 0
          
          if state.brightness < 0 {
            state.brightness = 0
          } else if state.brightness > 1 {
            state.brightness = 1
          }
          
          state.height = state.brightness * 140
          UIScreen.main.brightness = state.brightness
          
          return .concatenate([
            .cancel(id: CancelID.timer),
            .none
          ])
          
        case .dragEnd:
          return .run { send in
            for await _ in clock.timer(interval: .seconds(1)) {
              await send(.timerTicked)
            }
          }
          
        case .timerTicked:
          if state.hideTime == 0 {
            state.isDrag = false
            return .cancel(id: CancelID.timer)
          }
          state.hideTime -= 1
          return .none
      }
    }
  }
}
