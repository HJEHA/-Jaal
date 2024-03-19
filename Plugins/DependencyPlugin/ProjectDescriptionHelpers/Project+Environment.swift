import Foundation
import ProjectDescription

public extension Project {
  enum Environment {
    public static let appName = "WaistUp"
    public static let deploymentTarget = DeploymentTarget.iOS(
      targetVersion: "17.0",
      devices: [.iphone]
    )
    public static let bundlePrefix = "com.jeha.waistup"
  }
}
