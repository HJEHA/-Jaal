//
//  CalendarView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/9/24.
//

import SwiftUI

import ComposableArchitecture

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
      .padding(.horizontal, 20)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
  
  // MARK: - 월 표시 뷰
  private var monthView: some View {
    HStack(spacing: 16) {
      Button(
        action: {
          store.send(.changedMonth(-1))
        },
        label: {
          Image(systemName: "chevron.left")
            .padding()
        }
      )
      
      Text(store.monthTitle)
        .font(.title)
      
      Button(
        action: {
          store.send(.changedMonth(1))
        },
        label: {
          Image(systemName: "chevron.right")
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
          Text("Today")
            .padding()
        }
      )
      .padding(.trailing, 16)
    }
  }
  
  // MARK: - 일자 표시 뷰
  private var dayView: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
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
      }
      .onChange(of: store.isDayCenter, { oldValue, newValue in
        if newValue == true {
          proxy.scrollTo(store.todayID, anchor: .center)
        }
        store.send(.selectedToday(false))
      })
    }
  }
  
  // MARK: - 블러 뷰
  private var blurView: some View {
    HStack {
      LinearGradient(
        gradient: Gradient(
          colors: [
            Color.white.opacity(1),
            Color.white.opacity(0)
          ]
        ),
        startPoint: .leading,
        endPoint: .trailing
      )
      .frame(width: 20)
      .edgesIgnoringSafeArea(.leading)
      
      Spacer()
      
      LinearGradient(
        gradient: Gradient(
          colors: [
            Color.white.opacity(1),
            Color.white.opacity(0)
          ]
        ),
        startPoint: .trailing,
        endPoint: .leading
      )
      .frame(width: 20)
      .edgesIgnoringSafeArea(.trailing)
    }
  }
}
