//
//  DayInterface.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct DayStore {
  
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID = UUID()
    public let calendar: Calendar = Calendar.current
    
    public var date: Date = Date()
    
    public var day: String = ""
    public var dayNumber: String = ""
    
    public var isSelected: Bool = false
    
    public init(date: Date, isSelected: Bool) {
      self.date = date
      self.isSelected = isSelected
    }
  }
  
  public enum Action: Equatable {
    case onAppear
    case selected(Date)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
