//
//  WarningScreen.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/4/24.
//

import SwiftUI

public struct WarningScreen: View {
  @State var isAnimate: Bool = false
  
  public init(isAnimate: Bool = false) {
    self.isAnimate = isAnimate
  }
  
  public var body: some View {
    ZStack {
      SharedDesignSystemAsset.red.swiftUIColor.opacity(
        isAnimate ? 0.3 : 0
      )
      .edgesIgnoringSafeArea(.all)
      .animation(
        .linear(
          duration: isAnimate ? 0.5 : 0
        )
        .repeatForever(autoreverses: true),
        value: isAnimate
      )
    }
    .onAppear {
      isAnimate = true
    }
    .onDisappear {
      isAnimate = false
    }
  }
}

#Preview {
  WarningScreen()
}
