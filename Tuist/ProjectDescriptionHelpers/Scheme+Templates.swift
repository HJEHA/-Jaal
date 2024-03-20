import ProjectDescription
import DependencyPlugin

public extension Scheme {
  static var debug: Scheme {
    return makeScheme(
      target: .debug,
      name: "\(Project.Environment.appName) debug"
    )
  }
  
  static var release: Scheme {
    return makeScheme(
      target: .release,
      name: "\(Project.Environment.appName) release"
    )
  }
  
  private static func makeScheme(
    target: ConfigurationName,
    name: String
  ) -> Scheme {
    return Scheme(
      name: name,
      shared: true,
      buildAction: .buildAction(targets: ["\(Project.Environment.appName)"]),
      runAction: .runAction(configuration: target),
      archiveAction: .archiveAction(configuration: target),
      profileAction: .profileAction(configuration: target),
      analyzeAction: .analyzeAction(configuration: target)
    )
  }
}
