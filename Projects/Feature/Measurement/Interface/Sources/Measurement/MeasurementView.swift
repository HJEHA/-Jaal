//
//  MeasurementView.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/2/24.
//

import SwiftUI

import ComposableArchitecture

import DomainFaceTrackingInterface
import SharedDesignSystem

public struct MeasurementView: View {
  @Bindable public var store: StoreOf<MeasurementStore>
  @ObservedObject private var viewStore: ViewStoreOf<MeasurementStore>
  
  public init(store: StoreOf<MeasurementStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    ZStack {
      FaceTrackingView(
        store: store.scope(
          state: \.faceTracking,
          action: \.faceTracking
        )
      )
      
      Button(
        action: {
          viewStore.send(.closeButtonTapped)
        }, label: {
        Text("Button")
      })
    }
  }
}
