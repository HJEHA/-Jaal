//
//  ActivitiesView.swift
//  FeatureRecordInterface
//
//  Created by 황제하 on 5/2/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import SharedDesignSystem

public struct ActivitiesView<Content> : View where Content : View {
  
  @Bindable private var store: StoreOf<ActivitiesStore>
  private var content: () -> Content
  
  public init(
    store: StoreOf<ActivitiesStore>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.store = store
    self.content = content
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      measurementFilter
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
      
      if store.activities.count > 0 {
        activitys
        
        Spacer()
      } else {
        content()
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
      LazyVStack(spacing: 0) {
        ForEach(store.activities) { activity in
          NavigationLink(
            state: ActivityDetailStore.State(activity: activity)
          ) {
            ActivityCell(activity: activity)
          }
          .scrollTransition(
            topLeading: .identity,
            bottomTrailing: .animated.threshold(.visible(0.9))
          ) { content, phase in
            content
              .opacity(phase.isIdentity ? 1 : 0.7)
              .scaleEffect(phase.isIdentity ? 1 : 0.9)
              .blur(radius: phase.isIdentity ? 0 : 1)
          }
        }
      }
    }
  }
}
