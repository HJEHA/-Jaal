import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin


let targets: [Target] = [
  .app(
    implements: .IOS,
    factory: .init(
      infoPlist: .extendingDefault(
        with: [
          "UIRequiredDeviceCapabilities": [
            .string("ARKit")
          ],
          "UIUserInterfaceStyle": .string("Light"),
          "CFBundleShortVersionString": Project.Environment.marketingVersion,
          "CFBundleVersion": Project.Environment.buildVersion,
          "CFBundleDisplayName": .string("$(APP_NAME)"),
          "CFBundleName": "WaistUp",
          "CFBundleIconName": .string("$(PRODUCT_NAME)"),
          "UILaunchStoryboardName": .string("LaunchScreen"),
          "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": .boolean(false),
            "UISceneConfigurations": []
          ],
          "UISupportedInterfaceOrientations": [
            .string("UIInterfaceOrientationPortrait")
          ],
          "NSCameraUsageDescription": .string("이 앱은 카메라를 통해 사용자의 자세를 판단합니다."),
          "UIAppFonts": .array([
            .string("Gamtan-Bold.ttf"),
            .string("Gamtan-Regular.ttf"),
            .string("Gamtan-Thin.ttf"),
          ]),
        ]),
      dependencies: [
        .feature
      ],
      configurations: [
        .debug,
        .release
      ]
    )
  ),
]

let project: Project = .makeModule(
  name: "WaistUp",
  targets: targets,
  configurations: [
    .debug,
    .release
  ],
  schemes: [
    .debug,
    .release
  ]
)
