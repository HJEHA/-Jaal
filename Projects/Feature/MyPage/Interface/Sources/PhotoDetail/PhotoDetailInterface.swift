//
//  PhotoDetailInterface.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/17/24.
//

import UIKit

import ComposableArchitecture

import SharedUtil

@Reducer
public struct PhotoDetailStore {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public enum CancelID {
    case throttle
  }
  
  @ObservableState
  public struct State: Equatable {
    public var names: [String]
    public var index: Int
    public var currentPage: Int
    
    public var maxCount: Int {
      return names.count
    }
    
    public init(names: [String], index: Int) {
      self.names = names
      self.index = index
      self.currentPage = index + 1
    }
  }
  
  public enum Action: Equatable {
    case onAppear
    case closeButtonTapped
    
    case offsetChanged(CGFloat)
    case currentPage(Int)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
