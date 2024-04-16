import ProjectDescription
import ProjectDescriptionHelpers

let SPM = SwiftPackageManagerDependencies(
  [
    .remote(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      requirement: .upToNextMajor(from: "1.9.2")
    ),
    .remote(
      url: "https://github.com/onevcat/Kingfisher.git",
      requirement: .upToNextMajor(from: "7.0.0")
    )
  ]
)

let dependencies = Dependencies(
  swiftPackageManager: SPM,
  platforms: [.iOS]
)
