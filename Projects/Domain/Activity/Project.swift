import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Domain.name+ModulePath.Domain.Activity.rawValue,
  targets: [
    .domain(
      interface: .Activity,
      factory: .init(
        dependencies: [
          .core
        ]
      )
    ),
    .domain(
      implements: .Activity,
      factory: .init(
        dependencies: [
          .domain(interface: .Activity)
        ]
      )
    ),
    .domain(
      testing: .Activity,
      factory: .init(
        dependencies: [
          .domain(interface: .Activity)
        ]
      )
    ),
    .domain(
      tests: .Activity,
      factory: .init(
        dependencies: [
          .domain(testing: .Activity)
        ]
      )
    ),
  ],
  configurations: [.debug, .release]
)
