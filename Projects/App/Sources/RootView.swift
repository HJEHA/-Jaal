import SwiftUI

import ComposableArchitecture

import Feature
import DomainFaceTrackingInterface

struct RootView: View {
  public let store: StoreOf<RootStore>
  @ObservedObject var viewStore: ViewStoreOf<RootStore>
  
  public init(store: StoreOf<RootStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    MainTabView(store: store.scope(state: \.mainTab, action: RootStore.Action.mainTab))
  }
}
