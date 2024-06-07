//
//  MyPageRootView.swift
//  FeatureRecordInterface
//
//  Created by 황제하 on 4/9/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import SharedDesignSystem

public struct MyPageRootView: View {
  @Bindable private var store: StoreOf<RecordRootStore>
  
  public init(store: StoreOf<RecordRootStore>) {
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
        ) {
          KUEmptyView(
            description: "앗! 측정 기록이 없습니다."
          )
        }
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
  }
}

extension MyPageRootView {
  private var title: some View {
    Text("마이페이지")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
}
