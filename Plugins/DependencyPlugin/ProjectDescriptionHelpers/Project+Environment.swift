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
    public static let buildVersion = Plist.Value(stringLiteral: "1")
    public static let marketingVersion = Plist.Value(stringLiteral: "1.0.0")
  }
}
