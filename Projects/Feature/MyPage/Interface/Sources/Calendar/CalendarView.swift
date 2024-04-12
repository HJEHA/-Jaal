//
//  CalendarView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct CalendarView: View {
  
  private let store: StoreOf<CalendarStore>
  
  public init(store: StoreOf<CalendarStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(alignment: .center, spacing: 20) {
      ZStack {
        monthView
        todayView
      }
      
      
      ZStack {
        dayView
        blurView
      }
      .frame(height: 30)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}

extension CalendarView {
  private var monthView: some View {
    HStack(spacing: 16) {
      Button(
        action: {
          store.send(.changedMonth(-1))
        },
        label: {
          SharedDesignSystemAsset.chevronLeft.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(
              SharedDesignSystemAsset.blue.swiftUIColor
            )
            .padding()
        }
      )
      
      Text(store.monthTitle)
        .modifier(GamtanFont(font: .bold, size: 24))
      
      Button(
        action: {
          store.send(.changedMonth(1))
        },
        label: {
          SharedDesignSystemAsset.chevronRight.swiftUIImage
            .renderingMode(.template)
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(
              SharedDesignSystemAsset.blue.swiftUIColor
            )
            .padding()
        }
      )
    }
  }
  
  private var todayView: some View {
    HStack {
      Spacer()
      
      Button(
        action: {
          store.send(.selectedToday(true), animation: .default)
        },
        label: {
          Text("오늘")
            .modifier(GamtanFont(font: .bold, size: 20))
            .foregroundColor(
              SharedDesignSystemAsset.orange.swiftUIColor
            )
        }
      )
      .padding(.trailing, 16)
    }
  }
  
  private var dayView: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEachStore(
            store.scope(
              state: \.days,
              action: \.day
            )
          ) { store in
            DayView(store: store)
              .id(store.withState {
                $0.id
              })
          }
        }
        .padding(.horizontal, 20)
      }
      .onChange(of: store.isDayCenter, { oldValue, newValue in
        if newValue == true {
          proxy.scrollTo(store.todayID, anchor: .center)
        }
        store.send(.selectedToday(false))
      })
    }
  }
  
  private var blurView: some View {
    HStack {
      LinearGradient(
        gradient: Gradient(
          colors: [
            SharedDesignSystemAsset.gray100.swiftUIColor,
            Color.white.opacity(0)
          ]
        ),
        startPoint: .leading,
        endPoint: .trailing
      )
      .frame(width: 16)
      .edgesIgnoringSafeArea(.leading)
      
      Spacer()
      
      LinearGradient(
        gradient: Gradient(
          colors: [
            SharedDesignSystemAsset.gray100.swiftUIColor,
            Color.white.opacity(0)
          ]
        ),
        startPoint: .trailing,
        endPoint: .leading
      )
      .frame(width: 16)
      .edgesIgnoringSafeArea(.trailing)
    }
  }
}
