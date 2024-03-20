import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .shared(
    factory: .init(
      dependencies: [
        .shared(implements: .DesignSystem),
        .shared(implements: .ThirdPartyLib),
        .shared(implements: .Util)
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Shared",
  targets: targets,
  configurations: [.debug, .release]
)
