//
//  ScrollViewDidScrollViewModifier.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/19/24.
//

import Combine
import SwiftUI
import UIKit
import SwiftUIIntrospect

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

public extension ScrollView {
  func didScroll(_ didScroll: @escaping (CGPoint) -> Void) -> some View {
    self.modifier(ScrollViewDidScrollViewModifier(didScroll: didScroll))
  }
}
