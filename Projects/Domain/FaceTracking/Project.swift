import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Domain.name+ModulePath.Domain.FaceTracking.rawValue,
  targets: [
    .domain(
      interface: .FaceTracking,
      factory: .init(
        dependencies: [
          .core
        ]
      )
    ),
    .domain(
      implements: .FaceTracking,
      factory: .init(
        dependencies: [
          .domain(interface: .FaceTracking)
        ]
      )
    ),
    .domain(
      testing: .FaceTracking,
      factory: .init(
        dependencies: [
          .domain(interface: .FaceTracking)
        ]
      )
    ),
    .domain(
      tests: .FaceTracking,
      factory: .init(
        dependencies: [
          .domain(testing: .FaceTracking)
        ]
      )
    ),
  ],
  configurations: [.debug, .release]
)
