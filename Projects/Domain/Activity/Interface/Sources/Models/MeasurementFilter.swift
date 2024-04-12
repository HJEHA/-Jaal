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
  case nomal
  case focus
  
  public var title: String {
    switch self {
      case .all:
        return "모두"
      case .nomal:
        return "일반 모드"
      case .focus:
        return "집중 모드"
    }
  }
}
