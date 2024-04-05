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
  
  public init(store: StoreOf<MainTabStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      tabView(store)
      
      tabBarView(store)
    }
    .ignoresSafeArea(edges: [.bottom])
  }
  
  @ViewBuilder
  private func tabView(_ store: StoreOf<MainTabStore>) -> some View {
    if store.currentScene == .measurement {
      MeasurementRootView(
        store: store.scope(
          state: \.measurement,
          action: \.measurement
        )
      )
    } else {
      VStack {
        Spacer()
        HStack {
          Spacer()
        }
        
        Text(store.currentScene.title)
          .modifier(GamtanFont(font: .bold, size: 20))
        
        Spacer()
      }
    }
  }
  
  @ViewBuilder
  private func tabBarView(_ store: StoreOf<MainTabStore>) -> some View {
    ZStack {
      HStack {
        Spacer()
        
        tabBarItemView(store, scene: .home)
        
        Spacer()
        Spacer()
        Spacer()
        
        tabBarItemView(store, scene: .myPage)
        
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
      
      tabBarItemView(store, scene: .measurement)
        .frame(width: 56, height: 56)
        .offset(.init(width: 0, height: -15))
    }
    .frame(maxWidth: .infinity, maxHeight: 101)
  }
  
  @ViewBuilder
  private func tabBarItemView(
    _ store: StoreOf<MainTabStore>,
    scene: MainScene
  ) -> some View {
    VStack(spacing: .zero) {
      Button(action: {
        store.send(.selectTab(scene))
      }, label: {
        if case .measurement = scene {
          scene.image
            .renderingMode(.template)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(
              store.currentScene == scene
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
              store.currentScene == scene 
              ? SharedDesignSystemAsset.blue.swiftUIColor
              : SharedDesignSystemAsset.gray500.swiftUIColor
            )
        }
      })
      
      Text(scene.title)
        .foregroundColor(
          store.currentScene == scene 
          ? SharedDesignSystemAsset.blue.swiftUIColor
          : SharedDesignSystemAsset.gray500.swiftUIColor
        )
        .padding(.top, scene == .measurement ? 24 : 6)
        .padding(.bottom, 20)
        .modifier(GamtanFont(font: .bold, size: 12))
    }
    .onTapGesture {
      store.send(.selectTab(scene))
    }
  }
}
