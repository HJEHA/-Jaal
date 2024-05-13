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
        
        ScrollView {
          VStack(alignment: .leading) {
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
            .frame(maxHeight: 260)
            
            tipTitle
              .padding(.top, 36)
              .padding(.horizontal, 16)
            
            tips
              .padding(.vertical, 16)
              .padding(.horizontal, 16)
            
            Spacer()
          }
        }
        .scrollIndicators(.hidden)
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
    SharedDesignSystemAsset.logo.swiftUIImage
      .resizable()
      .frame(width: 120, height: 30)
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
  
  private var tipTitle: some View {
    Text("\(JaalUserDefaults.name)님을 위한 도움말")
      .modifier(GamtanFont(font: .bold, size: 18))
  }
  
  private var tips: some View {
    ZStack {
      SharedDesignSystemAsset.gray500.swiftUIColor
        .opacity(0.2)
      
      VStack(alignment: .leading) {
        TipCell(
          show: $store.showTip1,
          tip: .tip1
        )
        .onTapGesture {
          store.showTip1.toggle()
        }
        
        Divider()
          .padding(.horizontal, 16)
        
        TipCell(
          show: $store.showTip2,
          tip: .tip2
        )
        
        Divider()
          .padding(.horizontal, 16)
        
        TipCell(
          show: $store.showTip3,
          tip: .tip3
        )
        
        Divider()
          .padding(.horizontal, 16)
        
        source
      }
    }
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  private var source: some View {
    HStack {
      Spacer()
      
      Text("출처: 국가건강정보포털(health.kdca.go.kr)")
        .modifier(GamtanFont(font: .bold, size: 12))
        .foregroundColor(SharedDesignSystemAsset.gray600.swiftUIColor)
    }
    .padding(.top, 8)
    .padding([.horizontal, .bottom], 16)
  }
}
