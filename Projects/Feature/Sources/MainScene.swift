//
//  MainScene.swift
//  Feature
//
//  Created by 황제하 on 3/29/24.
//

import SwiftUI

import SharedDesignSystem

public enum MainScene: Hashable {
  case home
  case measurement
  case myPage
  
  var title: String {
    switch self {
      case .home:
        return "홈"
      case .measurement:
        return "측정하기"
      case .myPage:
        return "MY"
    }
  }
  
  var image: Image {
    switch self {
      case .home:
        return SharedDesignSystemAsset.home.swiftUIImage
      case .measurement:
        return SharedDesignSystemAsset.camera.swiftUIImage
      case .myPage:
        return SharedDesignSystemAsset.user.swiftUIImage
    }
  }
}
