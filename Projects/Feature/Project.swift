import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .feature(
    factory: .init(
      dependencies: [
        .domain,
        .feature(implements: .Measurement),
        .feature(implements: .MyPage)
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Feature",
  targets: targets,
  configurations: [.debug, .release]
)

