import Foundation
import ProjectDescription

public enum ModulePath {
  case feature(Feature)
  case domain(Domain)
  case core(Core)
  case shared(Shared)
}

// MARK: AppModule

public extension ModulePath {
  enum App: String, CaseIterable {
    case IOS
    
    public static let name: String = "App"
  }
}


// MARK: FeatureModule
public extension ModulePath {
  enum Feature: String, CaseIterable {
    case Onboarding
    case Home
    case Measurement
    case Record
    
    public static let name: String = "Feature"
  }
}

// MARK: DomainModule

public extension ModulePath {
  enum Domain: String, CaseIterable {
    case AlbumSaver
    case Activity
    case FaceTracking
    
    public static let name: String = "Domain"
  }
}

// MARK: CoreModule

public extension ModulePath {
  enum Core: String, CaseIterable {
    case UserDefaults
    case ImageProcss
    
    public static let name: String = "Core"
  }
}

// MARK: SharedModule

public extension ModulePath {
  enum Shared: String, CaseIterable {
    case Util
    case DesignSystem
    case ThirdPartyLib
    
    public static let name: String = "Shared"
  }
}
