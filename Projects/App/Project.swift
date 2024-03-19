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
            "ARKit"
          ],
          "UIUserInterfaceStyle": "Dark",
          "CFBundleShortVersionString": "1.2",
          "CFBundleVersion": "1",
          "CFBundleName": "WaistUp",
          "CFBundleIconName": "AppIcon",
          "UILaunchStoryboardName": "LaunchScreen",
          "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": []
          ],
          "NSCameraUsageDescription": "이 앱은 카메라를 통해 사용자의 자세를 판단합니다.",
        ]),
      dependencies: [
        .feature
      ]
    )
  ),
]

let project: Project = .makeModule(
  name: "WaistUp",
  targets: targets
)
