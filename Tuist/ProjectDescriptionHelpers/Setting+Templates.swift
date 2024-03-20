import ProjectDescription
import DependencyPlugin

public extension Settings {
  static private let baseSettings: [String: SettingValue] = [
    "MARKETING_VERSION": .string("1.0.2"),
    "CURRENT_PROJECT_VERSION": .string("33"),
    "CODE_SIGN_STYLE": "Automatic",
    "PRODUCT_NAME": "$(TARGET_NAME)",
    "DEVELOPMENT_TEAM": "$(TEAM_ID)",
    "INFOPLIST_KEY_CFBundleDisplayName": "$(APP_NAME)",
    "ENABLE_PREVIEWS": "YES"
  ]
  
  static var debugSettings: [String: SettingValue] {
    let debug: [String: SettingValue] = [
      "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "DEBUG",
      "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon_Debug",
      "SWIFT_OPTIMIZATION_LEVEL": "-Onone"
    ]
    
    return baseSettings.merging(debug, uniquingKeysWith: { _, debug in debug})
  }
  
  static var releaseSettings: [String: SettingValue] {
    let debug: [String: SettingValue] = [
      "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "RELEASE",
      "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
      "SWIFT_OPTIMIZATION_LEVEL": "-O"
    ]
    
    return baseSettings.merging(debug, uniquingKeysWith: { _, release in release})
  }
}

