//
//  MeasurementFilter.swift
//  DomainActivityInterface
//
//  Created by 황제하 on 4/12/24.
//

import Foundation

public enum MeasurementFilter: CaseIterable, Identifiable {
  public var id: Self { self }
  
  case all
  case normal
  case focus
  
  public var title: String {
    switch self {
      case .all:
        return "모두"
      case .normal:
        return "일반 모드"
      case .focus:
        return "집중 모드"
    }
  }
  
  public static func toMeasurementMode(_ index: Int) -> MeasurementMode? {
    switch MeasurementFilter.allCases[index] {
      case .all:
        return nil
      case .normal:
        return .normal
      case .focus:
        return .focus
    }
  }
}
