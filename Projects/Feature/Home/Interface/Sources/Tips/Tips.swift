//
//  Tips.swift
//  FeatureHomeInterface
//
//  Created by 황제하 on 5/3/24.
//

import SwiftUI

import SharedDesignSystem

public enum Tip: CaseIterable {
  case tip1
  case tip2
  case tip3
  
  var title: String {
    switch self {
      case .tip1:
        return "거북목 증후군의 원인은\n무엇인가요?"
      case .tip2:
        return "어떤 증상이 발생하나요?"
      case .tip3:
        return "어떻게 예방할 수 있나요?"
    }
  }
  
  var description: String {
    switch self {
      case .tip1:
        return """
        스마트폰이나 컴퓨터의 과사용이
        1차 원인이 되고 있습니다.
        바르지 못한 자세로 오랫동안 앉아 있거나
        생활하는 것이 제일 큰 원인입니다.
        """
      case .tip2:
        return """
        - 목덜미와 어깻죽지가 뻐근합니다.
        - 팔도 저리고, 시리고 근육 속이 아픈 통증이 생깁니다.
        - 수면을 방해하며 만성피로를 느끼게 됩니다.
        """
      case .tip3:
        return """
        - 모니터 높이기
        - 운전 중 요추 경추 전만 유지하기
        - 스마트폰을 볼 경우, 무조건 높이 들기
        - 서거나 걸을 때 허리를 꼿꼿이 유지하기
        """
    }
  }
  
  var image: Image {
    switch self {
      case .tip1:
        return Image(systemName: "tortoise.fill")
      case .tip2:
        return Image(systemName: "person.fill.questionmark")
      case .tip3:
        return Image(systemName: "heart.text.square.fill")
    }
  }
  
  var color: Color {
    switch self {
      case .tip1:
        return SharedDesignSystemAsset.blue.swiftUIColor
      case .tip2:
        return SharedDesignSystemAsset.orange.swiftUIColor
      case .tip3:
        return SharedDesignSystemAsset.beige.swiftUIColor
    }
  }
}
