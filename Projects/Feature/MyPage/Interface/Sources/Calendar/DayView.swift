//
//  DayView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct DayView: View {
  
  private let store: StoreOf<DayStore>
  
  public init(store: StoreOf<DayStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      Text(store.day)
        .modifier(GamtanFont(font: .regular, size: 18))
      Text(store.dayNumber)
        .modifier(GamtanFont(font: .regular, size: 14))
    }
    .frame(width: 40, height: 40)
    .padding(5)
    .background(
      store.isSelected
      ? SharedDesignSystemAsset.blue.swiftUIColor
      : Color.clear
    )
    .cornerRadius(16)
    .foregroundColor(store.isSelected ? .white : .black)
    .onTapGesture {
      store.send(.selected(store.date))
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
