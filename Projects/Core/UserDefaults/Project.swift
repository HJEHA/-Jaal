import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Core.name+ModulePath.Core.UserDefaults.rawValue,
  targets: [
    .core(
      interface: .UserDefaults,
      factory: .init(
        dependencies: [
          .shared
        ]
      )
    ),
    .core(
      implements: .UserDefaults,
      factory: .init(
        dependencies: [
          .core(interface: .UserDefaults)
        ]
      )
    ),
    .core(
      testing: .UserDefaults,
      factory: .init(
        dependencies: [
          .core(interface: .UserDefaults)
        ]
      )
    ),
    .core(
      tests: .UserDefaults,
      factory: .init(
        dependencies: [
          .core(testing: .UserDefaults)
        ]
      )
    ),
  ],
  configurations: [.debug, .release]
)
