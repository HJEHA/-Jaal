//
//  MeasurementView.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/1/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct MeasurementView: View {
  public let store: StoreOf<MeasurementStore>
  @ObservedObject private var viewStore: ViewStoreOf<MeasurementStore>
  
  public init(store: StoreOf<MeasurementStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      title
        .padding(.leading, 16)
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

extension MeasurementView {
  private var title: some View {
    Text("측정하기")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
  
  private var selectedMode: some View {
    Text("모드 선택")
      .modifier(GamtanFont(font: .bold, size: 20))
  }
  
  @ViewBuilder
  private func modeSelectButton(
    _ viewStore: ViewStoreOf<MeasurementStore>,
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
