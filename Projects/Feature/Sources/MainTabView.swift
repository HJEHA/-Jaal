//
//  MainTabView.swift
//  Feature
//
//  Created by 황제하 on 3/29/24.
//

import SwiftUI

import ComposableArchitecture

import FeatureHomeInterface
import FeatureMeasurementInterface
import FeatureMyPageInterface
import SharedDesignSystem

public struct MainTabView: View {
  
  public let store: StoreOf<MainTabStore>
  private var viewStore: ViewStoreOf<MainTabStore>
  
  public init(store: StoreOf<MainTabStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    TabView(
      selection: viewStore.binding(
        get: \.selection,
        send: MainTabStore.Action.selectionChanged
      )
    ) {
      HomeRootView(
        store: store.scope(
          state: \.home,
          action: \.home
        )
      )
      .tabItem {
        Text("\(MainScene.home.title)")
        Image(systemName: "\(MainScene.home.imageName)")
      }
      .tag(0)
      
      MeasurementRootView(
        store: store.scope(
          state: \.measurement,
          action: \.measurement
        )
      )
      .tabItem {
        Text("\(MainScene.measurement.title)")
        Image(systemName: "\(MainScene.measurement.imageName)")
      }
      .tag(1)
      
      MyPageRootView(
        store: store.scope(
          state: \.myPage,
          action: \.myPage
        )
      )
      .badge(store.newActivityBadge)
      .tabItem {
        Text("\(MainScene.myPage.title)")
        Image(systemName: "\(MainScene.myPage.imageName)")
      }
      .tag(2)
    }
    .onAppear {
      UITabBar.appearance().backgroundColor = SharedDesignSystemAsset.gray50.color
      UITabBar.appearance().scrollEdgeAppearance = .init()
    }
    .tint(SharedDesignSystemAsset.blue.swiftUIColor)
  }
}
