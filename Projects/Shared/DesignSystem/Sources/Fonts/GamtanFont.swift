//
//  GamtanFont.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/2/24.
//

import SwiftUI

public struct GamtanFont: ViewModifier {
  let font: Font.GamtanFont
  let size: CGFloat
  
  public init(
    font: Font.GamtanFont,
    size: CGFloat
  ) {
    self.font = font
    self.size = size
  }
  
  public func body(content: Content) -> some View {
    content
      .font(
        Font(font.size(size))
      )
  }
}

public extension Font {
  enum GamtanFont {
    case bold
    case regular
    case thin
    
    func size(_ size: CGFloat) -> CTFont {
      switch self {
        case .bold:
          return SharedDesignSystemFontFamily.GamtanRoadDotumTTF.bold.font(size: size)
        case .regular:
          return SharedDesignSystemFontFamily.GamtanRoadDotumTTF.regular.font(size: size)
        case .thin:
          return SharedDesignSystemFontFamily.GamtanRoadDotumTTF.thin.font(size: size)
      }
    }
  }
}
