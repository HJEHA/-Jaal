//
//  HomeRootView.swift
//  FeatureHomeInterface
//
//  Created by 황제하 on 4/24/24.
//

import SwiftUI

import ComposableArchitecture

import FeatureMyPageInterface
import CoreUserDefaults
import SharedDesignSystem

public struct HomeRootView: View {
  @Bindable private var store: StoreOf<HomeRootStore>
  
  public init(store: StoreOf<HomeRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack(
      path: $store.scope(
        state: \.activities.path,
        action: \.activities.path
      )
    ) {
      VStack(alignment: .leading) {
        title
          .padding(.horizontal, 16)
          .padding(.vertical, 8)
                  
        ActivitiesView(
          store: store.scope(
            state: \.activities,
            action: \.activities
          )
        )
      }
      .onAppear {
        store.send(.onAppear)
      }
    } destination: { store in
      ActivityDetailView(store: store)
        .toolbarRole(.editor)
    }
  }
}

extension HomeRootView {
  private var title: some View {
    Text("홈")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
}
