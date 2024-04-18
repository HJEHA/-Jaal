//
//  PhotoDetailView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/17/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem
import SharedUtil

struct ScrollOffsetKey: PreferenceKey {
  typealias Value = CGFloat
  
  static var defaultValue: CGFloat = 0
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value += nextValue()
  }
}

public struct PhotoDetailView: View {
  private let store: StoreOf<PhotoDetailStore>
  
  public init(store: StoreOf<PhotoDetailStore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      
      ScrollViewReader { proxy in
        ScrollView(.horizontal) {
          GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).origin.x
            Color.clear.preference(key: ScrollOffsetKey.self, value: offset)
          }
          .frame(width: 0, height: 0)
          
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
        .scrollTargetBehavior(.paging)
        .onAppear {
          proxy.scrollTo(store.index)
        }
        .onChange(of: store.index) { _, newValue in
          withAnimation {
            proxy.scrollTo(newValue)
          }
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetKey.self) { value in
          store.send(.offsetChanged(value))
        }
      }
      
      VStack {
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
        
        Spacer()
        
        HStack {
          Button {
            store.send(.preButtonTapped)
          } label: {
            SharedDesignSystemAsset.chevronLeft.swiftUIImage
              .renderingMode(.template)
              .resizable()
              .foregroundColor(
                store.preButtomDisabled
                ? SharedDesignSystemAsset.gray600.swiftUIColor
                : .white
              )
              .frame(width: 36, height: 36)
          }
          .disabled(store.preButtomDisabled)
          
          
          Spacer()
          
          Text("\(store.currentPage) / \(store.maxCount)")
            .modifier(GamtanFont(font: .bold, size: 14))
            .foregroundColor(.white)
          
          Spacer()
          
          Button {
            store.send(.nextButtonTapped)
          } label: {
            SharedDesignSystemAsset.chevronRight.swiftUIImage
              .renderingMode(.template)
              .resizable()
              .foregroundColor(
                store.nextButtomDisabled
                ? SharedDesignSystemAsset.gray600.swiftUIColor
                : .white
              )
              .frame(width: 36, height: 36)
          }
          .disabled(store.nextButtomDisabled)
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
