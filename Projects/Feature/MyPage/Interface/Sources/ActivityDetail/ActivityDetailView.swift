//
//  ActivityDetailView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/15/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct ActivityDetailView: View {
  private let store: StoreOf<ActivityDetailStore>
  
  public init(store: StoreOf<ActivityDetailStore>) {
    self.store = store
  }
  
  public var body: some View {
    Text("\(store.activity.blinkCount)")
  }
}
