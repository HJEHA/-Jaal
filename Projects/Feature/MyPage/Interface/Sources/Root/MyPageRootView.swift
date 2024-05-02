//
//  MyPageRootView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import SwiftUI

import ComposableArchitecture

import FeatureOnboardingInterface
import DomainActivityInterface
import SharedDesignSystem

public struct MyPageRootView: View {
  @Bindable private var store: StoreOf<MyPageRootStore>
  
  public init(store: StoreOf<MyPageRootStore>) {
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
        HStack {
          title
          
          Spacer()
          
          menu
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        CalendarView(
          store: store.scope(
            state: \.calendar,
            action: \.calendar
          )
        )
        .padding(.vertical, 8)
        
        ActivitiesView(
          store: store.scope(
            state: \.activities,
            action: \.activities
          )
        )
      }
      .background(SharedDesignSystemAsset.gray100.swiftUIColor)
      .onAppear {
        store.send(.onAppear)
      }
    } destination: { store in
      ActivityDetailView(store: store)
        .toolbarRole(.editor)
    }
    .tint(SharedDesignSystemAsset.blue.swiftUIColor)
    .sheet(
      item: $store.scope(
        state: \.onboardingProfile,
        action: \.onboardingProfile
      )
    ) { store in
      OnboardingProfileView(store: store)
    }
    .sheet(
      item: $store.scope(
        state: \.onboardingAvatar,
        action: \.onboardingAvatar
      )
    ) { store in
      OnboardingAvatarView(store: store)
    }
    .confirmationDialog(
      "",
      isPresented: $store.showResetActionSheet
    ) {
      Button("초기화", role: .destructive) {
        store.send(.resetButtonTapped)
      }
      Button("취소", role: .cancel) {
        store.showResetActionSheet = false
      }
    } message: {
      Text("모든 측정 기록 및 이미지가 삭제됩니다.\n정말 초기화 하시겠습니까?")
    }
  }
}

extension MyPageRootView {
  private var title: some View {
    Text("마이페이지")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
  
  private var menu: some View {
    Menu {
      Button("프로필 변경") {
        store.send(.editProfileButtonTapped)
      }
      Button("아바타 변경") {
        store.send(.editAvatarButtonTapped)
      }
      
      Divider()
      
      Button(role: .destructive) {
        store.showResetActionSheet = true
      } label: {
        Label("초기화", systemImage: "trash")
      }
    } label: {
      Image(systemName: "ellipsis.circle")
        .resizable()
        .frame(width: 20, height: 20)
    }
  }
}
