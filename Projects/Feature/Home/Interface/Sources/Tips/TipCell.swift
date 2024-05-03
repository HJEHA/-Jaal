//
//  TipCell.swift
//  FeatureHomeInterface
//
//  Created by 황제하 on 5/3/24.
//

import SwiftUI

import SharedDesignSystem

public struct TipCell: View {
  
  @Binding private var show: Bool
  private var tip: Tip
  
  public init(
    show: Binding<Bool>,
    tip: Tip
  ) {
    self._show = show
    self.tip = tip
  }
  
  public var body: some View {
    Button {
      show.toggle()
    } label: {
      VStack(alignment: .leading) {
        HStack {
          makeTipIcon(
            image: tip.image,
            color: tip.color
          )
          
          Text("\(tip.title)")
            .modifier(GamtanFont(font: .bold, size: 16))
            .lineSpacing(8)
            .multilineTextAlignment(.leading)
            .foregroundColor(
              SharedDesignSystemAsset.gray800.swiftUIColor
            )
            .frame(minHeight: 40)
          
          Spacer()
                    
          SharedDesignSystemAsset.chevronDown.swiftUIImage
            .resizable()
            .renderingMode(.template)
            .frame(width: 18, height: 18)
            .foregroundColor(
              SharedDesignSystemAsset.gray800.swiftUIColor
            )
            .rotationEffect(
              show == true
              ? Angle(degrees: 180)
              : Angle(degrees: 0)
            )
        }
        
        if show == true {
          Text("\(tip.description)")
            .modifier(GamtanFont(font: .bold, size: 14))
            .lineSpacing(8)
            .multilineTextAlignment(.leading)
            .foregroundColor(
              SharedDesignSystemAsset.gray700.swiftUIColor
            )
            .padding(.top, 4)
        }
      }
      .padding(16)
    }
  }
}

extension TipCell {
  private func makeTipIcon(
    image: Image,
    color: Color
  ) -> some View {
    return ZStack {
      LinearGradient(
        gradient: Gradient(
          colors: [
            SharedDesignSystemAsset.gray600.swiftUIColor,
            color
          ]
        ),
        startPoint: .bottomLeading,
        endPoint: .topTrailing
      )
      .frame(width: 60, height: 60)
      .clipShape(Circle())
      
      image
        .renderingMode(.template)
        .foregroundColor(.white)
        .imageScale(.large)
        .scaleEffect(1.5)
    }
  }
}
