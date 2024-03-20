import ProjectDescription
import DependencyPlugin

public extension Project {
  static func makeModule(
    name: String,
    targets: [Target],
    configurations: [Configuration] = [],
    schemes: [Scheme] = []
  ) -> Self {
    let name: String = name
    let organizationName: String? = nil
    let packages: [Package] = []
    let targets: [Target] = targets
    let fileHeaderTemplate: FileHeaderTemplate? = nil
    let additionalFiles: [FileElement] = []
    let resourceSynthesizers: [ResourceSynthesizer] = []
    
    let settings: Settings = .settings(
      configurations: configurations,
      defaultSettings: .recommended
    )
    
    return .init(
      name: name,
      organizationName: organizationName,
      options: .options(
        defaultKnownRegions: ["Base", "ko"],
        developmentRegion: "ko"
      ),
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: schemes,
      fileHeaderTemplate: fileHeaderTemplate,
      additionalFiles: additionalFiles,
      resourceSynthesizers: resourceSynthesizers
    )
  }
}
