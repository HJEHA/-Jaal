//
//  SaveSuccessView.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/19/24.
//

import SwiftUI

public struct SaveSuccessView: View {
  @State private var isAnimating = false
  private var completion: (() -> Void)?
  
  public init(
    completion: (() -> Void)? = nil
  ) {
    self.completion = completion
  }
  
  public var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .frame(
          width: isAnimating ? 90 : 0,
          height: isAnimating ? 90 : 0
        )
        .foregroundColor(SharedDesignSystemAsset.gray200.swiftUIColor)
        .animation(
          .spring(.bouncy, blendDuration: 0.4),
          value: isAnimating
        )
      
      SharedDesignSystemAsset.disk.swiftUIImage
        .renderingMode(.template)
        .resizable()
        .frame(width: isAnimating ? 50 : 0, height: isAnimating ? 50 : 0)
        .foregroundColor(.gray)
        .animation(
          .spring(.bouncy, blendDuration: 0.4).delay(0.2),
          value: isAnimating
        )
      
      Path { path in
        path.move(to: CGPoint(x: 20, y: -40))
        path.addLine(to: CGPoint(x: 40, y: -20))
        path.addLine(to: CGPoint(x: 80, y: -60))
      }
      .trim(from: 0, to: isAnimating ? 1 : 0)
      .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
      .foregroundColor(SharedDesignSystemAsset.blue.swiftUIColor)
      .offset(x: 150, y: 460)
      .animation(
        .spring(.bouncy, blendDuration: 0.2).delay(0.8),
        value: isAnimating
      )
      
    }
    .onAppear {
      isAnimating = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
        completion?()
      }
    }
    .onDisappear {
      isAnimating = false
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.02))
    .ignoresSafeArea()
  }
}
