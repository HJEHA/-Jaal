import SwiftUI

import FeatureMeasurement
import FeatureMeasurementInterface

@main
struct AppView: App {
  var body: some Scene {
    WindowGroup {
      MeasurementRootView(
        store: .init(initialState: MeasurementRootStore.State()) {
          MeasurementRootStore()
        }
      )
    }
  }
}

