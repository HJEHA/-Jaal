//
//  MeasurementView.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/1/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct MeasurementRootView: View {
  public let store: StoreOf<MeasurementRootStore>
  @ObservedObject private var viewStore: ViewStoreOf<MeasurementRootStore>
  
  public init(store: StoreOf<MeasurementRootStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      HStack {
        title
        
        Spacer()
        
        startButton
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      
      selectedMode
        .padding(.leading, 20)
        .padding(.top, 12)
      
      
      HStack {
        modeSelectButton(viewStore, mode: .nomal)
        
        modeSelectButton(viewStore, mode: .focus)
      }
      .padding(.horizontal, 20)
      .padding(.top, 8)
      
      Spacer()
    }
    .background(SharedDesignSystemAsset.gray100.swiftUIColor)
  }
}

extension MeasurementRootView {
  private var title: some View {
    Text("측정하기")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
  
  private var selectedMode: some View {
    Text("모드 선택")
      .modifier(GamtanFont(font: .bold, size: 20))
  }
  
  private var startButton: some View {
    Button(action: {
      print("시작")
    }, label: {
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(
          SharedDesignSystemAsset.beige.swiftUIColor
        )
        .frame(width: 120, height: 56)
        .overlay(
          HStack {
            Image(
              uiImage: viewStore.selectedMode == .nomal
              ? SharedDesignSystemAsset.play.image
              : SharedDesignSystemAsset.flame.image
            )
            .renderingMode(.template)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(
              viewStore.selectedMode == .nomal
              ? SharedDesignSystemAsset.orange.swiftUIColor
              : SharedDesignSystemAsset.red.swiftUIColor
            )
            
            Text("측정 시작")
              .modifier(GamtanFont(font: .bold, size: 18))
              .foregroundColor(
                viewStore.selectedMode == .nomal
                ? SharedDesignSystemAsset.orange.swiftUIColor
                : SharedDesignSystemAsset.red.swiftUIColor
              )
          }
        )
    })
  }
  
  @ViewBuilder
  private func modeSelectButton(
    _ viewStore: ViewStoreOf<MeasurementRootStore>,
    mode: MeasurementMode
  ) -> some View {
    Button(action: {
      viewStore.send(.modeButtonTapped(mode))
    }, label: {
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(
          viewStore.selectedMode == mode
          ? SharedDesignSystemAsset.blue.swiftUIColor
          : SharedDesignSystemAsset.gray500.swiftUIColor
        )
        .frame(height: 64)
        .overlay(
          Text(mode.title)
            .modifier(GamtanFont(font: .bold, size: 24))
            .foregroundColor(.white)
        )
    })
  }
}
