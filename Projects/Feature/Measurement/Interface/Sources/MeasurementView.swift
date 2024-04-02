//
//  MeasureementView.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/1/24.
//

import SwiftUI

import ComposableArchitecture

public struct MeasurementView: View {
  public let store: StoreOf<MeasurementStore>
  @ObservedObject private var viewStore: ViewStoreOf<MeasurementStore>
  
  public init(store: StoreOf<MeasurementStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    Text("d")
  }
}
