//
//  MeasurementStartView.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 5/12/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct MeasurementStartView: View {
  @Bindable public var store: StoreOf<MeasurementStartStore>
  
  public var body: some View {
    ZStack {
      VStack {
        initialTimer
        description
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}

extension MeasurementStartView {
  private var initialTimer: some View {
    Text("\(store.initialTimerCount)")
      .foregroundColor(
        SharedDesignSystemAsset.blue.swiftUIColor
      )
      .modifier(SamlipFont(size: 100))
      .padding(4)
  }
  
  private var description: some View {
    Text("바른 자세를\n유지해주세요")
      .modifier(SamlipFont(size: 50))
      .multilineTextAlignment(.center)
      .padding(20)
      .background(
        SharedDesignSystemAsset.gray100.swiftUIColor
          .opacity(0.5)
      )
      .clipShape(RoundedRectangle(cornerRadius: 16))
  }
}
