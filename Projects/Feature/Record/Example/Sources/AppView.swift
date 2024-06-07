import SwiftUI

import FeatureRecord
import FeatureRecordInterface

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      MyPageRootView(
        store: .init(initialState: RecordRootStore.State()) {
          RecordRootStore()
        }
      )
    }
  }
}

