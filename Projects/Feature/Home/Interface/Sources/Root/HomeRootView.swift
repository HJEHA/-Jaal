//
//  HomeRootView.swift
//  FeatureHomeInterface
//
//  Created by 황제하 on 4/24/24.
//

import SwiftUI

import ComposableArchitecture

struct HomeRootView: View {
  private let store: StoreOf<HomeRootStore>
  
  public init(store: StoreOf<HomeRootStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      Text("홈")
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
