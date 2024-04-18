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
  
  @ObservableState
  public struct State: Equatable {
    public var names: [String]
    public var index: Int
    
    public var maxCount: Int {
      return names.count
    }
    
    public var currentImage: UIImage {
      if let key = names[safe: index],
         let image = ImageCache.shared.loadImageFromDiskCache(forKey: key)
      {
        return image
      }
      return UIImage()
    }
    
    public init(names: [String], index: Int) {
      self.names = names
      self.index = index
    }
  }
  
  public enum Action: Equatable {
    case onAppear
    case nextButtonTapped
    case preButtonTapped
    case closeButtonTapped
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
