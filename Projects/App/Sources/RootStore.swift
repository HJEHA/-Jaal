import Foundation

import ComposableArchitecture

import Feature

@Reducer
public struct RootStore {
  
  @ObservableState
  public struct State: Equatable {
    public var mainTab: MainTabStore.State = .init()
  }
  
  public enum Action: Equatable {
    case mainTab(MainTabStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.mainTab, action: /Action.mainTab) {
      MainTabStore()
    }
    Reduce { state, action in
      switch action {
        case .mainTab:
          return .none
      }
    }
  }
}
