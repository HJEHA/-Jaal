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
            .stroke(style: .init(lineWidth: 6, lineCap: .round))
            .foregroundColor(SharedDesignSystemAsset.blue.swiftUIColor)
            .rotationEffect(
              Angle(
                degrees: isAnimating ? 360 : 0
              )
            )
            .animation(
              .linear(
                duration: isAnimating ? 1 : 0
              )
              .repeatForever(autoreverses: false),
              value: isAnimating
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
    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.02))
    .ignoresSafeArea()
  }
}
