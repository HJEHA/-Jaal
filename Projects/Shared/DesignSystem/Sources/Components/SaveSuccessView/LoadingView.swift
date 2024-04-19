//
//  SaveSuccessView.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/19/24.
//

import SwiftUI

public struct LoadingView: View {
  @State private var isAnimating = false
  
  public init(isAnimating: Bool = false) {
    self.isAnimating = isAnimating
  }
  
  public var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .frame(width: 90, height: 90)
        .foregroundColor(SharedDesignSystemAsset.gray200.swiftUIColor)
      
      Circle()
        .foregroundColor(.clear)
        .frame(width: 50, height: 50)
        .overlay(
          Circle()
            .trim(from: 0, to: 0.85)
            .stroke(lineWidth: 6)
            .foregroundColor(SharedDesignSystemAsset.blue.swiftUIColor)
            .rotationEffect(
              Angle(
                degrees: self.isAnimating ? 360 : 0
              )
            )
            .animation(
              .linear(
                duration: self.isAnimating ? 1 : 0
              )
              .repeatForever(autoreverses: false)
            )
        )
      
    }
    .onAppear {
      isAnimating = true
    }
    .onDisappear {
      isAnimating = false
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(SharedDesignSystemAsset.gray200.swiftUIColor.opacity(0.2))
    .ignoresSafeArea()
  }
}
