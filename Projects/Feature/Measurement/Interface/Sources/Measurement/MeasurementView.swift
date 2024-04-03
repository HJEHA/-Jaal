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
      
      VStack(alignment: .leading) {
        closeButton
          .padding(.horizontal, 16)
          .padding(.vertical, 16)
        
        Spacer()
      }
    }
  }
}

extension MeasurementView {
  private var closeButton: some View {
    Button(
      action: {
        viewStore.send(.closeButtonTapped)
      }, label: {
        SharedDesignSystemAsset.cross.swiftUIImage
          .renderingMode(.template)
          .resizable()
          .frame(width: 30, height: 30)
          .foregroundColor(
            SharedDesignSystemAsset.gray900.swiftUIColor
          )
      }
    )
  }
}
