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
        .opacity(store.backgroundOpacity)
      
      scrollView
        .offset(x: 0, y: store.closeDragHeight)
      
      VStack {
        
        closeButton
          .offset(
            x: 0,
            y: store.isDrag ? -100 : 0
          )
        
        Spacer()
        
        countView
          .offset(
            x: 0,
            y: store.isDrag ? 100 : 0
          )
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .gesture(
      dragGesture
    )
    .introspect(.viewController, on: .iOS(.v17)) { viewController in
      viewController.view.backgroundColor = .clear
      viewController.modalTransitionStyle = .crossDissolve
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
    .padding(12)
  }
  
  var dragGesture: some Gesture {
    DragGesture()
      .onChanged { value in
        let height = value.translation.height
        if abs(height) > 50 {
          store.send(.closeDraged(height))
          
          if store.isDrag == false {
            store.send(.startCloseDrag(true), animation: .easeInOut)
          }
        }
        
      }
      .onEnded { _ in
        store.send(.closeDraged(0), animation: .easeInOut)
        if store.isDrag == true {
          store.send(.startCloseDrag(false), animation: .easeInOut)
        }
      }
  }
}
