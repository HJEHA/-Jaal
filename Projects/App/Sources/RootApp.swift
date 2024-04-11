import SwiftUI
import SwiftData

import ComposableArchitecture

import DomainActivity

@main
struct RootApp: App {
  @Dependency(\.activityClient) var activityClient
  var modelContext: ModelContext {
    guard let modelContext = try? self.activityClient.context() else {
      fatalError("Could not find modelcontext")
    }
    return modelContext
  }
  
  var body: some Scene {
    WindowGroup {
      RootView(
        store: .init(initialState: RootStore.State()) {
          RootStore()
        }
      )
      .modelContext(modelContext)
    }
  }
}
