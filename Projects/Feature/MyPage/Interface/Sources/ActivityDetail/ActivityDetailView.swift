//
//  ActivityDetailView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/15/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import SharedDesignSystem
import SharedUtil

public struct ActivityDetailView: View {
  private let store: StoreOf<ActivityDetailStore>
  
  public init(store: StoreOf<ActivityDetailStore>) {
    self.store = store
  }
  
  private var color: Color {
    switch store.activity.measurementMode {
      case .normal:
        return SharedDesignSystemAsset.orange.swiftUIColor
      case .focus:
        return SharedDesignSystemAsset.red.swiftUIColor
    }
  }
  
  public var body: some View {
    ZStack {
      SharedDesignSystemAsset.gray100.swiftUIColor
        .ignoresSafeArea()
      
      VStack {
        simpleInfoView
      }
    }
    .navigationTitle(store.navigationBartitle)
  }
}

extension ActivityDetailView {
  func makeIcon(_ mode: MeasurementMode) -> some View {
    let icon: Image
    
    switch mode {
      case .normal:
        icon = SharedDesignSystemAsset.user.swiftUIImage
      case .focus:
        icon = SharedDesignSystemAsset.flame.swiftUIImage
    }
    
    return ZStack {
      LinearGradient(
        gradient: Gradient(
          colors: [
            SharedDesignSystemAsset.gray600.swiftUIColor,
            color
          ]
        ),
        startPoint: .bottomLeading,
        endPoint: .topTrailing
      )
      .frame(width: 90, height: 90)
      .clipShape(Circle())
      
      icon
        .renderingMode(.template)
        .resizable()
        .foregroundColor(.white)
        .frame(width: 45, height: 45)
    }
  }
  
  var simpleInfoView: some View {
    HStack {
      makeIcon(store.activity.measurementMode)
        .padding(.leading, 16)
        .padding(.trailing, 6)
        .padding(.vertical, 10)
      
      VStack(alignment: .leading) {
        title
        mode
        
        Spacer()
        
        dateRange
      }
      .padding(.vertical, 20)
      .frame(height: 100)
      
      Spacer()
    }
  }
  
  var title: some View {
    Text(store.activity.title)
      .modifier(GamtanFont(font: .bold, size: 18))
      .foregroundColor(
        SharedDesignSystemAsset.gray800.swiftUIColor
      )
  }
  
  var mode: some View {
    Text(store.activity.measurementMode.title)
      .modifier(GamtanFont(font: .bold, size: 16))
      .foregroundColor(color)
  }
  
  var dateRange: some View {
    return Text(store.dateRange)
      .modifier(GamtanFont(font: .bold, size: 18))
      .foregroundColor(
        SharedDesignSystemAsset.gray800.swiftUIColor
      )
  }
}
