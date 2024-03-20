import ProjectDescription

public enum ProjectDeployTarget: String {
  case debug = "Debug"
  case release = "Release"
  
  var identifierName: String {
    return self.rawValue
  }
}

public extension ConfigurationName {
  static var debug: ConfigurationName {
    ConfigurationName.configuration(
      ProjectDeployTarget.debug.identifierName
    )
  }
  
  static var release: ConfigurationName {
    ConfigurationName.configuration(
      ProjectDeployTarget.release.identifierName
    )
  }
}

public extension Configuration {
  static var debug: Configuration {
    Configuration.debug(
      name: ConfigurationName.debug,
      settings: Settings.debugSettings,
      xcconfig: .relativeToRoot("XCConfig/Debug.xcconfig")
    )
  }
  
  static var release: Configuration {
    Configuration.release(
      name: ConfigurationName.release,
      settings: Settings.releaseSettings,
      xcconfig: .relativeToRoot("XCConfig/Release.xcconfig")
    )
  }
}
