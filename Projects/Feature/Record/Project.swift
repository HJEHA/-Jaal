import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Feature.name+ModulePath.Feature.Record.rawValue,
  targets: [
    .feature(
      interface: .Record,
      factory: .init(
        dependencies: [
          .domain
        ]
      )
    ),
    .feature(
      implements: .Record,
      factory: .init(
        dependencies: [
          .feature(interface: .Record)
        ]
      )
    ),
    .feature(
      testing: .Record,
      factory: .init(
        dependencies: [
          .feature(interface: .Record)
        ]
      )
    ),
    .feature(
      tests: .Record,
      factory: .init(
        dependencies: [
          .feature(testing: .Record)
        ]
      )
    ),
    .feature(
      example: .Record,
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
          .feature(interface: .Record)
        ],
        configurations: [.debug, .release]
      )
    )
  ],
  configurations: [.debug, .release]
)
