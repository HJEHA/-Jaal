//
//  BrightnessView.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/8/24.
//

import SwiftUI

import ComposableArchitecture

public struct BrightnessView: View {
  
  public let store: StoreOf<BrightnessStore>
  
  public init(store: StoreOf<BrightnessStore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack(alignment: .leading) {
      Color.white.opacity(0.0001)
      
      if store.isDrag == true {
        VStack(alignment: .center, spacing: 16) {
          SharedDesignSystemAsset.sunMax.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 32, height: 32)
          
          ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 8)
              .foregroundColor(
                SharedDesignSystemAsset.gray400.swiftUIColor
              )
              .frame(width: 16, height: 140)
            
            RoundedRectangle(cornerRadius: 8)
              .foregroundColor(.white)
              .frame(width: 16, height: store.height)
          }
          
          SharedDesignSystemAsset.sunMin.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 32, height: 32)
        }
        .padding(.leading, 16)
      }
    }
    .ignoresSafeArea()
    .gesture(
      DragGesture()
        .onChanged { gesture in
          store.send(.dragged(gesture.translation.height))
        }
        .onEnded { _ in
          store.send(.dragEnd)
        }
    )
  }
}
