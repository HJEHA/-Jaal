import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Domain.name+ModulePath.Domain.AlbumSaver.rawValue,
  targets: [
    .domain(
      interface: .AlbumSaver,
      factory: .init(
        dependencies: [
          .core
        ]
      )
    ),
    .domain(
      implements: .AlbumSaver,
      factory: .init(
        dependencies: [
          .domain(interface: .AlbumSaver)
        ]
      )
    ),
    .domain(
      testing: .AlbumSaver,
      factory: .init(
        dependencies: [
          .domain(interface: .AlbumSaver)
        ]
      )
    ),
    .domain(
      tests: .AlbumSaver,
      factory: .init(
        dependencies: [
          .domain(testing: .AlbumSaver)
        ]
      )
    ),
  ],
  configurations: [.debug, .release]
)
