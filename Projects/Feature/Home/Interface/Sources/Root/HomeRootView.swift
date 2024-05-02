//
//  HomeRootView.swift
//  FeatureHomeInterface
//
//  Created by 황제하 on 4/24/24.
//

import SwiftUI

import ComposableArchitecture

import FeatureMyPageInterface
import CoreUserDefaults
import SharedDesignSystem

public struct HomeRootView: View {
  @Bindable private var store: StoreOf<HomeRootStore>
  
  public init(store: StoreOf<HomeRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack(
      path: $store.scope(
        state: \.activities.path,
        action: \.activities.path
      )
    ) {
      VStack(alignment: .leading) {
        title
          .padding(.horizontal, 16)
          .padding(.vertical, 8)
              
        HStack {
          todayActivity
          
          Spacer()
          
          activityMoreButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        ActivitiesView(
          store: store.scope(
            state: \.activities,
            action: \.activities
          )
        ) {
          VStack {
            JaalEmptyView(
              description: "앗! 측정 기록이 없습니다."
            )
            
            goToMeamentsureButton
          }
        }
        .frame(height: store.activities.activities.isEmpty ? 300 : 420)
        
        Spacer()
      }
      .background(SharedDesignSystemAsset.gray100.swiftUIColor)
      .onAppear {
        store.send(.onAppear)
      }
    } destination: { store in
      ActivityDetailView(store: store)
        .toolbarRole(.editor)
    }
  }
}

extension HomeRootView {
  private var title: some View {
    Text("홈")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
  
  private var todayActivity: some View {
    Text("오늘의 측정 기록")
      .modifier(GamtanFont(font: .bold, size: 18))
  }
  
  private var activityMoreButton: some View {
    Button {
      store.send(.activityMoreButtonTapped)
    } label: {
      HStack(spacing: 0) {
        Text("모든 기록 보기")
          .modifier(GamtanFont(font: .bold, size: 14))
          .foregroundColor(
            SharedDesignSystemAsset.orange.swiftUIColor
          )
        
        SharedDesignSystemAsset.chevronRight.swiftUIImage
          .renderingMode(.template)
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundColor(
            SharedDesignSystemAsset.orange.swiftUIColor
          )
      }
    }
  }
  
  private var goToMeamentsureButton: some View {
    Button{
      store.send(.goToMeamentsureButtonTapped)
    } label: {
      HStack(spacing: 0) {
      
      Text("측정하러 가기")
        .modifier(GamtanFont(font: .bold, size: 18))
        .foregroundColor(
          SharedDesignSystemAsset.orange.swiftUIColor
        )
        
        SharedDesignSystemAsset.chevronRight.swiftUIImage
          .renderingMode(.template)
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(
            SharedDesignSystemAsset.orange.swiftUIColor
          )
      }
    }
  }
}
