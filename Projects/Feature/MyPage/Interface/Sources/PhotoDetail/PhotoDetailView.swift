//
//  PhotoDetailView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/17/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct PhotoDetailView: View {
  private let store: StoreOf<PhotoDetailStore>
  
  public init(store: StoreOf<PhotoDetailStore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      Color.black
          .ignoresSafeArea()
      
      Image(uiImage: store.currentImage)
        .resizable()
        .scaledToFit()
        .scaleEffect(0.8)
      
      VStack {
        HStack {
          SharedDesignSystemAsset.cross.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 20, height: 20)
            .onTapGesture {
              store.send(.closeButtonTapped)
            }
          
          Spacer()
        }
        .background(
          Color.black.opacity(0.3)
        )
        .padding(12)
        
        Spacer()
        
        HStack {
          SharedDesignSystemAsset.chevronLeft.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 36, height: 36)
          
          Spacer()
          
          Text("\(store.index + 1) / \(store.maxCount)")
            .modifier(GamtanFont(font: .bold, size: 14))
            .foregroundColor(.white)
          
          Spacer()
          
          SharedDesignSystemAsset.chevronRight.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .foregroundColor(.white)
            .frame(width: 36, height: 36)
        }
        .background(
          Color.black.opacity(0.3)
        )
        .padding(12)
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
