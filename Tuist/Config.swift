import ProjectDescription

let config = Config(
  compatibleXcodeVersions: [.all],
  plugins: [
    .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
  ]
)
