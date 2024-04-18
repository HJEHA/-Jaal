import ProjectDescription
import ProjectDescriptionHelpers

let SPM = SwiftPackageManagerDependencies(
  [
    .remote(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      requirement: .upToNextMajor(from: "1.9.2")
    ),
    .remote(
      url: "https://github.com/siteline/swiftui-introspect",
      requirement: .upToNextMajor(from: "1.0.0")
    )
  ]
)

let dependencies = Dependencies(
  swiftPackageManager: SPM,
  platforms: [.iOS]
)
