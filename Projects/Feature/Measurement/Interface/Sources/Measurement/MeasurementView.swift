//
//  MeasurementView.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/2/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct MeasurementView: View {
  @Bindable public var store: StoreOf<MeasurementStore>
  
  public init(store: StoreOf<MeasurementStore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      trackingView
            
      if store.isWarning == true {
        WarningScreen()
      }
      
      if store.isInitailing == true {
        initialTimer
      }
      
      VStack(alignment: .leading) {
        HStack {
          closeButton
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
          
          Spacer()
        }
        
        if store.isInitailing == false {
          timer
            .padding(.top, 20)
          
          eyeBlink
            .padding(.top, 8)
        }
        
        Spacer()
      }
    }
    .onAppear {
      store.send(.appear)
    }
    .onChange(of: store.sharedState.isEyeClose) { _, newValue in
      if newValue == false {
        store.send(.eyeBlinked)
      }
    }
  }
}

extension MeasurementView {
  private var trackingView: some View {
    FaceTrackingView(
      store: store.scope(
        state: \.faceTracking,
        action: \.faceTracking
      )
    )
  }
  
  private var closeButton: some View {
    Button(
      action: {
        store.send(.closeButtonTapped)
      }, label: {
        SharedDesignSystemAsset.cross.swiftUIImage
          .renderingMode(.template)
          .resizable()
          .frame(width: 30, height: 30)
          .foregroundColor(
            SharedDesignSystemAsset.gray100.swiftUIColor
          )
      }
    )
  }
  
  private var initialTimer: some View {
    VStack {
      Text("\(store.initialTimerCount)")
        .foregroundColor(
          SharedDesignSystemAsset.blue.swiftUIColor
        )
        .modifier(SamlipFont(size: 100))
        .padding(4)
      
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
  
  private var timer: some View {
    HStack {
      Spacer()
      
      SharedDesignSystemAsset.clock.swiftUIImage
        .renderingMode(.template)
        .resizable()
        .frame(width: 30, height: 30)
        .foregroundColor(
          SharedDesignSystemAsset.orange.swiftUIColor
        )
        .padding(.bottom, 4)
      
      Text(store.timeString)
        .modifier(SamlipFont(size: 44))
        .foregroundColor(
          SharedDesignSystemAsset.orange.swiftUIColor
        )
        .padding(4)
      
      Spacer()
    }
  }
  
  private var eyeBlink: some View {
    HStack {
      Spacer()
      
      SharedDesignSystemAsset.eye.swiftUIImage
        .renderingMode(.template)
        .resizable()
        .frame(width: 30, height: 30)
        .foregroundColor(
          SharedDesignSystemAsset.blue.swiftUIColor
        )
        .padding(.bottom, 4)
      
      Text("\(store.eyeBlinkCount)")
        .modifier(SamlipFont(size: 44))
        .foregroundColor(
          SharedDesignSystemAsset.blue.swiftUIColor
        )
        .padding(4)
      
      Spacer()
    }
  }
}
