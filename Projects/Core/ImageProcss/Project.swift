import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Core.name+ModulePath.Core.ImageProcss.rawValue,
  targets: [
    .core(
      interface: .ImageProcss,
      factory: .init(
        dependencies: [
          .shared
        ]
      )
    ),
    .core(
      implements: .ImageProcss,
      factory: .init(
        dependencies: [
          .core(interface: .ImageProcss)
        ]
      )
    ),
    .core(
      testing: .ImageProcss,
      factory: .init(
        dependencies: [
          .core(interface: .ImageProcss)
        ]
      )
    ),
    .core(
      tests: .ImageProcss,
      factory: .init(
        dependencies: [
          .core(testing: .ImageProcss)
        ]
      )
    ),
  ],
  configurations: [.debug, .release]
)
