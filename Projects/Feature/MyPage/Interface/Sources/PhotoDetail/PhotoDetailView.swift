//
//  PhotoDetailView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/17/24.
//

import SwiftUI
import Combine

import ComposableArchitecture
import SwiftUIIntrospect

import SharedDesignSystem
import SharedUtil

public struct PhotoDetailView: View {
  private let store: StoreOf<PhotoDetailStore>
  
  public init(store: StoreOf<PhotoDetailStore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      
      scrollView
      
      VStack {
        
        closeButton
        
        Spacer()
        
        countView
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}

extension PhotoDetailView {
  var scrollView: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(store.names.indices, id: \.self) { index in
            let image = ImageCache.shared.loadImageFromDiskCache(
              forKey: store.names[index]) ?? UIImage()
            Image(uiImage: image)
              .resizable()
              .frame(width: UIScreen.main.bounds.width)
              .scaledToFit()
              .scaleEffect(0.8)
              .id(index)
          }
        }
      }
      .didScroll { offset in
        store.send(.offsetChanged(offset.x))
      }
      .scrollTargetBehavior(.paging)
      .onAppear {
        proxy.scrollTo(store.index)
      }
    }
  }
  
  var closeButton: some View {
    HStack {
      Button {
        store.send(.closeButtonTapped)
      } label: {
        SharedDesignSystemAsset.cross.swiftUIImage
          .renderingMode(.template)
          .resizable()
          .foregroundColor(.white)
          .frame(width: 20, height: 20)
      }
      Spacer()
    }
    .background(
      Color.black.opacity(0.3)
    )
    .padding(12)
  }
  
  var countView: some View {
    HStack {
      Spacer()
      
      Text("\(store.currentPage) / \(store.maxCount)")
        .modifier(GamtanFont(font: .bold, size: 14))
        .foregroundColor(.white)
      
      Spacer()
    }
    .background(
      Color.black.opacity(0.3)
    )
    .padding(12)
  }
}
