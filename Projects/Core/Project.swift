import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .core(
    factory: .init(
      dependencies: [
        .shared
      ]
    )
  )
]


let project: Project = .makeModule(
  name: "Core",
  targets: targets,
  configurations: [.debug, .release]
)
