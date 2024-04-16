import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .shared(
    implements: .ThirdPartyLib,
    factory: .init(
      dependencies: [
        .external(name: "ComposableArchitecture"),
        .external(name: "Kingfisher")
      ]
    )
  )
]

let project: Project = .init(
  name: "SharedThirdPartyLib",
  targets: targets
)
