//
//  WarningScreen.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/4/24.
//

import SwiftUI

public struct WarningScreen: View {
  @State var isAnimating: Bool = false
  
  public init(isAnimate: Bool = false) {
    self.isAnimating = isAnimate
  }
  
  public var body: some View {
    ZStack {
      SharedDesignSystemAsset.red.swiftUIColor.opacity(
        isAnimating ? 0.3 : 0
      )
      .edgesIgnoringSafeArea(.all)
      .animation(
        .linear(
          duration: isAnimating ? 0.5 : 0
        )
        .repeatForever(autoreverses: true),
        value: isAnimating
      )
    }
    .onAppear {
      isAnimating = true
    }
    .onDisappear {
      isAnimating = false
    }
  }
}
