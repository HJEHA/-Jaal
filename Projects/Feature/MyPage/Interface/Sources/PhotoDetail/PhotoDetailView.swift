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
      
      Image(systemName: "heart.fill")
      
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
        .padding(12)
      }
    }
  }
}
