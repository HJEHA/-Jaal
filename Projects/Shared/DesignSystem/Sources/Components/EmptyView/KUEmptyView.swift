//
//  KUEmptyView.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/24/24.
//

import SwiftUI

public struct KUEmptyView: View {
  
  private let description: String
  
  public init(description: String) {
    self.description = description
  }
  
  public var body: some View {
    VStack {
      Rectangle()
        .frame(height: 0)
      
      Spacer()
      
      SharedDesignSystemAsset.oops.swiftUIImage
        .resizable()
        .frame(width: 100, height: 100)
      
      Text(description)
        .modifier(GamtanFont(font: .bold, size: 18))
        .multilineTextAlignment(.center)
        .foregroundColor(
          SharedDesignSystemAsset.gray700.swiftUIColor
        )
      
      Spacer()
    }
  }
}
