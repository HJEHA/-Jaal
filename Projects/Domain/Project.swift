import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .domain(
    factory: .init(
      dependencies: [
        .domain(implements: .FaceTracking),
        .domain(implements: .Activity),
        .domain(implements: .AlbumSaver),
        .core
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Domain",
  targets: targets,
  configurations: [.debug, .release]
)
