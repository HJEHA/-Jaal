//
//  SkinColors.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/26/24.
//

import UIKit

public enum SkinColors: CaseIterable {
  case skin0
  case skin1
  case skin2
  case skin3
  case skin4
  
  public var color: UIColor {
    switch self {
      case .skin0:
        return SharedDesignSystemAsset.skin0.color
      case .skin1:
        return SharedDesignSystemAsset.skin1.color
      case .skin2:
        return SharedDesignSystemAsset.skin2.color
      case .skin3:
        return SharedDesignSystemAsset.skin3.color
      case .skin4:
        return SharedDesignSystemAsset.skin4.color
    }
  }
}
