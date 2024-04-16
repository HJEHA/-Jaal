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
    case MyPage
    case Measurement
    
    public static let name: String = "Feature"
  }
}

// MARK: DomainModule

public extension ModulePath {
  enum Domain: String, CaseIterable {
    case Activity
    case FaceTracking
    
    public static let name: String = "Domain"
  }
}

// MARK: CoreModule

public extension ModulePath {
  enum Core: String, CaseIterable {
    case ImageProcss
    case UserDefaultsManager
    
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
