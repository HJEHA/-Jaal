//
//  ActivitiesView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 5/2/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import SharedDesignSystem

public struct ActivitiesView: View {
  
  @Bindable private var store: StoreOf<ActivitiesStore>
  
  public init(store: StoreOf<ActivitiesStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      measurementFilter
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
      
      if store.activities.count > 0 {
        activitys
        
        Spacer()
      } else {
        JaalEmptyView(
          description: "앗! 측정 기록이 없습니다."
        )
      }
    }
  }
}

extension ActivitiesView {
  private var measurementFilter: some View {
    CustomSegmentedControl(
      selection: $store.filterIndex,
      size: CGSize(width: UIScreen.main.bounds.width - 32, height: 52),
      segmentLabels: MeasurementFilter.allCases.map { $0.title }
    )
  }
  
  private var activitys: some View {
    ScrollView(.vertical) {
      VStack(spacing: 8) {
        ForEach(store.activities) { activity in
          NavigationLink(
            state: ActivityDetailStore.State(activity: activity)
          ) {
            ActivityCell(activity: activity)
          }
        }
      }
      .padding(.bottom, 40)
    }
  }
}
