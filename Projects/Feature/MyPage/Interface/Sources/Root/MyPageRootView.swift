//
//  MyPageRootView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct MyPageRootView: View {
  private let store: StoreOf<MyPageRootStore>
  
  public init(store: StoreOf<MyPageRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      HStack {
        title
        
        Spacer()
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      
      CalendarView(
        store: store.scope(
          state: \.calendar,
          action: \.calendar
        )
      )
      .padding(.vertical, 8)
      
      Spacer()
    }
    .background(SharedDesignSystemAsset.gray100.swiftUIColor)
    .onAppear {
      store.send(.appear)
    }
  }
}


extension MyPageRootView {
  private var title: some View {
    Text("마이페이지")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
}
