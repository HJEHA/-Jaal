//
//  MyPageRootView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import SharedDesignSystem

public struct MyPageRootView: View {
  private let store: StoreOf<MyPageRootStore>
  private var viewStore: ViewStoreOf<MyPageRootStore>
  
  public init(store: StoreOf<MyPageRootStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      HStack {
        title
        
        Spacer()
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
      
      measurementFilter
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
      
      ScrollView(.vertical) {
        ForEach(store.activities) {
          ActivityCell(activity: $0)
        }
      }
      
      Spacer()
    }
    .background(SharedDesignSystemAsset.gray100.swiftUIColor)
    .onAppear {
      store.send(.appear)
    }
  }
}


extension MyPageRootView {
  private var title: some View {
    Text("마이페이지")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
  
  private var measurementFilter: some View {
    CustomSegmentedControl(
      selection: viewStore.binding(
        get: \.filterIndex,
        send: MyPageRootStore.Action.filterSelected
      ),
      size: CGSize(width: UIScreen.main.bounds.width - 32, height: 52),
      segmentLabels: MeasurementFilter.allCases.map { $0.title }
    )
  }
}
