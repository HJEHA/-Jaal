import SwiftUI

import ComposableArchitecture

import Feature
import DomainFaceTrackingInterface

struct RootView: View {
  public let store: StoreOf<RootStore>
  
  public init(store: StoreOf<RootStore>) {
    self.store = store
  }
  
  var body: some View {
    MainTabView(
      store: store.scope(
        state: \.mainTab,
        action: \.mainTab
      )
    )
  }
}
