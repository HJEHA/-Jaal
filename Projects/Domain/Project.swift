import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .domain(
    factory: .init(
      dependencies: [
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
