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
    .onAppear {
      store.send(.onAppear)
    }
  }
}

struct ScrollViewDidScrollViewModifier: ViewModifier {
  
  class ViewModel: ObservableObject {
    var contentOffsetSubscription: AnyCancellable?
  }
  
  @StateObject var viewModel = ViewModel()
  var didScroll: (CGPoint) -> Void
  
  func body(content: Content) -> some View {
    content
      .introspect(.scrollView, on: .iOS(.v17)) { scrollView in
        if viewModel.contentOffsetSubscription == nil {
          viewModel.contentOffsetSubscription = scrollView.publisher(
            for: \.contentOffset
          )
          .sink { contentOffset in
            didScroll(contentOffset)
          }
        }
      }
  }
}

extension ScrollView {
  func didScroll(_ didScroll: @escaping (CGPoint) -> Void) -> some View {
    self.modifier(ScrollViewDidScrollViewModifier(didScroll: didScroll))
  }
}
