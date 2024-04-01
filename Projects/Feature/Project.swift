import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .feature(
    factory: .init(
      dependencies: [
        .domain,
        .feature(implements: .Measurement),
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Feature",
  targets: targets,
  configurations: [.debug, .release]
)

