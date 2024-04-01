import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Feature.name+ModulePath.Feature.Measurement.rawValue,
  targets: [
    .feature(
      interface: .Measurement,
      factory: .init(
        dependencies: [
          .domain
        ]
      )
    ),
    .feature(
      implements: .Measurement,
      factory: .init(
        dependencies: [
          .feature(interface: .Measurement)
        ]
      )
    ),
    .feature(
      testing: .Measurement,
      factory: .init(
        dependencies: [
          .feature(interface: .Measurement)
        ]
      )
    ),
    .feature(
      tests: .Measurement,
      factory: .init(
        dependencies: [
          .feature(testing: .Measurement)
        ]
      )
    ),
    .feature(
      example: .Measurement,
      factory: .init(
        infoPlist: .extendingDefault(
          with: [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UILaunchStoryboardName": "LaunchScreen",
            "UIApplicationSceneManifest": [
              "UIApplicationSupportsMultipleScenes": false,
              "UISceneConfigurations": []
            ]
          ]
        ),
        dependencies: [
          .feature(interface: .Measurement)
        ],
        configurations: [.debug, .release]
      )
    )
  ],
  configurations: [.debug, .release]
)
