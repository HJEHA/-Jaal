//
//  MeasurementEndView.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 5/13/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem
import SharedUtil

public struct MeasurementEndView: View {

  private let store: StoreOf<MeasurementEndStore>
  
  public init(store: StoreOf<MeasurementEndStore>) {
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
    ZStack(alignment: .center) {
      SharedDesignSystemAsset.gray300.swiftUIColor
        .opacity(0.7)
      
      VStack(alignment:.center) {
        title
        
        infoView
          .padding(.top, 20)
        
        closeButton
          .padding(.top, 12)
      }
      .frame(width: 240)
      .padding(16)
      .background(
        SharedDesignSystemAsset.gray200.swiftUIColor
      )
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(color: .gray, radius: 1, x: 1, y: 1)
      
    }
    .ignoresSafeArea()
    .onTapGesture {
      store.send(.closeButtonTapped)
    }
  }
}

extension MeasurementEndView {
  private var title: some View {
    Text("측정 결과")
      .modifier(GamtanFont(font: .bold, size: 20))
      .foregroundColor(
        SharedDesignSystemAsset.gray800.swiftUIColor
      )
  }
  
  private var infoView: some View {
    VStack(alignment: .center) {
      makeDetailInfo(
        title: "제목",
        value: store.activity.title,
        color: SharedDesignSystemAsset.gray900.swiftUIColor
      )
      
      Divider()
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
      
      makeDetailInfo(
        title: "측정 시간",
        value: TimeFormatter.toClockString(
          from: store.activity.activityDuration
        ),
        color: color
      )
      
      Divider()
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
      
      makeDetailInfo(
        title: "눈 깜빡임 수",
        value: "\(store.activity.blinkCount)",
        color: SharedDesignSystemAsset.blue.swiftUIColor
      )
    }
  }
  
  private func makeDetailInfo(
    title: String,
    value: String,
    color: Color
  ) -> some View {
    VStack(alignment: .center, spacing: 8) {
      Text(title)
        .modifier(GamtanFont(font: .bold, size: 14))
        .foregroundColor(
          SharedDesignSystemAsset.gray700.swiftUIColor
        )
      
      Text(value)
        .modifier(GamtanFont(font: .bold, size: 24))
        .foregroundColor(color)
    }
  }
  
  private var closeButton: some View {
    Button(action: {
      store.send(.closeButtonTapped)
    }, label: {
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(
          SharedDesignSystemAsset.gray300.swiftUIColor
        )
        .frame(width: 220, height: 56)
        .overlay(
          Text("닫기")
            .modifier(GamtanFont(font: .bold, size: 18))
            .foregroundColor(
              SharedDesignSystemAsset.gray700.swiftUIColor
            )
        )
    })
  }
}
