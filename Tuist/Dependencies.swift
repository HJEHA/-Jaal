import ProjectDescription
import ProjectDescriptionHelpers

let SPM = SwiftPackageManagerDependencies(
  [
    .remote(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      requirement: .upToNextMajor(from: "1.9.2")
    )
  ]
)

let dependencies = Dependencies(
  swiftPackageManager: SPM,
  platforms: [.iOS]
)
