//
//  MainTabView.swift
//  Feature
//
//  Created by 황제하 on 3/29/24.
//

import SwiftUI

import ComposableArchitecture

import FeatureMeasurementInterface
import SharedDesignSystem

public struct MainTabView: View {
  
  public let store: StoreOf<MainTabStore>
  @ObservedObject private var viewStore: ViewStoreOf<MainTabStore>
  
  public init(store: StoreOf<MainTabStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      tabView(viewStore)
      
      tabBarView(viewStore)
    }
    .ignoresSafeArea(edges: [.bottom])
  }
  
  @ViewBuilder
  private func tabView(_ viewStore: ViewStoreOf<MainTabStore>) -> some View {
    if viewStore.currentScene == .measurement {
      MeasurementRootView(
        store: store.scope(
          state: \.measurement,
          action: MainTabStore.Action.measurement
        )
      )
    } else {
      VStack {
        Spacer()
        HStack {
          Spacer()
        }
        
        Text(viewStore.currentScene.title)
          .modifier(GamtanFont(font: .bold, size: 20))
        
        Spacer()
      }
    }
  }
  
  @ViewBuilder
  private func tabBarView(_ viewStore: ViewStoreOf<MainTabStore>) -> some View {
    ZStack {
      HStack {
        Spacer()
        
        tabBarItemView(viewStore, scene: .home)
        
        Spacer()
        Spacer()
        Spacer()
        
        tabBarItemView(viewStore, scene: .myPage)
        
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: 101)
      .background(SharedDesignSystemAsset.gray50.swiftUIColor)
      .overlay(
        Rectangle()
          .frame(width: nil, height: 1, alignment: .top)
          .foregroundColor(SharedDesignSystemAsset.gray200.swiftUIColor),
        alignment: .top
      )
      
      tabBarItemView(viewStore, scene: .measurement)
        .frame(width: 56, height: 56)
        .offset(.init(width: 0, height: -15))
    }
    .frame(maxWidth: .infinity, maxHeight: 101)
  }
  
  @ViewBuilder
  private func tabBarItemView(
    _ viewStore: ViewStoreOf<MainTabStore>,
    scene: MainScene
  ) -> some View {
    VStack(spacing: .zero) {
      Button(action: {
        viewStore.send(.selectTab(scene))
      }, label: {
        if case .measurement = scene {
          scene.image
            .renderingMode(.template)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(
              viewStore.currentScene == scene
              ? SharedDesignSystemAsset.blue.swiftUIColor
              : SharedDesignSystemAsset.gray500.swiftUIColor
            )
            .background(
              Circle()
                .fill(SharedDesignSystemAsset.gray50.swiftUIColor)
                .frame(width: 68, height: 68)
            )
            .overlay(
              RoundedRectangle(cornerRadius: 34)
                .stroke(
                  SharedDesignSystemAsset.gray200.swiftUIColor,
                  lineWidth: 1
                )
                .frame(width: 68, height: 68)
            )
        } else {
          scene.image
            .renderingMode(.template)
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundColor(
              viewStore.currentScene == scene 
              ? SharedDesignSystemAsset.blue.swiftUIColor
              : SharedDesignSystemAsset.gray500.swiftUIColor
            )
        }
      })
      
      Text(scene.title)
        .foregroundColor(
          viewStore.currentScene == scene 
          ? SharedDesignSystemAsset.blue.swiftUIColor
          : SharedDesignSystemAsset.gray500.swiftUIColor
        )
        .padding(.top, scene == .measurement ? 24 : 6)
        .padding(.bottom, 20)
        .modifier(GamtanFont(font: .bold, size: 12))
    }
    .onTapGesture {
      viewStore.send(.selectTab(scene))
    }
  }
}
