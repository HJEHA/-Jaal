//
//  SamlipFont.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/4/24.
//

import SwiftUI

public struct SamlipFont: ViewModifier {
  let font: Font.SamlipFont = .outline
  let size: CGFloat
  
  public init(
    size: CGFloat
  ) {
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
  enum SamlipFont {
    case outline
    
    func size(_ size: CGFloat) -> CTFont {
      switch self {
        case .outline:
          return SharedDesignSystemFontFamily.SandollSamliphopangcheTTF.ou.font(size: size)
      }
    }
  }
}
