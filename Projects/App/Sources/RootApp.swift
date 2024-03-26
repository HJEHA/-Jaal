import SwiftUI

import ComposableArchitecture

@main
struct RootApp: App {
  var body: some Scene {
    WindowGroup {
      RootView(
        store: .init(initialState: RootStore.State()) {
          RootStore()
        }
      )
    }
  }
}
