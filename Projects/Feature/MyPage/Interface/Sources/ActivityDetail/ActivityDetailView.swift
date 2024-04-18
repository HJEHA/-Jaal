//
//  ActivityDetailView.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/15/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import SharedDesignSystem
import SharedUtil

public struct ActivityDetailView: View {
  private var columns: [GridItem] = Array(
    repeating: .init(.flexible()),
    count: 3
  )
  @Bindable private var store: StoreOf<ActivityDetailStore>
  
  public init(store: StoreOf<ActivityDetailStore>) {
    self.store = store
  }
  
  private var color: Color {
    switch store.activity.measurementMode {
      case .normal:
        return SharedDesignSystemAsset.orange.swiftUIColor
      case .focus:
        return SharedDesignSystemAsset.red.swiftUIColor
    }
  }
  
  public var body: some View {
    ZStack {
      SharedDesignSystemAsset.gray100.swiftUIColor
        .ignoresSafeArea()
      
      ScrollView {
        VStack(alignment: .leading) {
          simpleInfoView
          
          infoTitle
            .padding(.leading, 16)
            .padding(.top, 20)
          
          infoView
            .padding(.horizontal, 16)
          
          timeLapseTitle
            .padding(.leading, 16)
            .padding(.top, 20)
          
          timeLapseGridView
            .padding(.horizontal, 16)
          
          Spacer()
        }
      }
    }
    .navigationTitle(store.navigationBartitle)
    .onAppear {
      store.send(.onAppear)
    }
    .fullScreenCover(
      item: $store.scope(state: \.photoDetail, action: \.photoDetail)
    ) { store in
      PhotoDetailView(store: store)
    }
  }
}

extension ActivityDetailView {
  func makeIcon(_ mode: MeasurementMode) -> some View {
    let icon: Image
    
    switch mode {
      case .normal:
        icon = SharedDesignSystemAsset.user.swiftUIImage
      case .focus:
        icon = SharedDesignSystemAsset.flame.swiftUIImage
    }
    
    return ZStack {
      LinearGradient(
        gradient: Gradient(
          colors: [
            SharedDesignSystemAsset.gray600.swiftUIColor,
            color
          ]
        ),
        startPoint: .bottomLeading,
        endPoint: .topTrailing
      )
      .frame(width: 90, height: 90)
      .clipShape(Circle())
      
      icon
        .renderingMode(.template)
        .resizable()
        .foregroundColor(.white)
        .frame(width: 45, height: 45)
    }
  }
  
  var simpleInfoView: some View {
    HStack {
      makeIcon(store.activity.measurementMode)
        .padding(.leading, 16)
        .padding(.trailing, 6)
        .padding(.vertical, 10)
      
      VStack(alignment: .leading) {
        title
        mode
        
        Spacer()
        
        dateRange
      }
      .padding(.vertical, 20)
      .frame(height: 100)
      
      Spacer()
    }
  }
  
  var title: some View {
    Text(store.activity.title)
      .modifier(GamtanFont(font: .bold, size: 18))
      .foregroundColor(
        SharedDesignSystemAsset.gray800.swiftUIColor
      )
  }
  
  var mode: some View {
    Text(store.activity.measurementMode.title)
      .modifier(GamtanFont(font: .bold, size: 16))
      .foregroundColor(color)
  }
  
  var dateRange: some View {
    return Text(store.dateRange)
      .modifier(GamtanFont(font: .bold, size: 18))
      .foregroundColor(
        SharedDesignSystemAsset.gray800.swiftUIColor
      )
  }
  
  var infoTitle: some View {
    return Text("세부사항")
      .modifier(GamtanFont(font: .bold, size: 20))
      .foregroundColor(
        SharedDesignSystemAsset.gray700.swiftUIColor
      )
  }
  
  var infoView: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading) {
        makeDetailInfo(
          title: "측정 시간",
          value: TimeFormatter.toClockString(from: store.activity.activityDuration),
          color: color
        )
        
        Divider()
          .padding(.bottom, 8)
        
        makeDetailInfo(
          title: "눈 깜빡임 수",
          value: "\(store.activity.blinkCount)",
          color: SharedDesignSystemAsset.blue.swiftUIColor
        )
      }
      
      VStack(alignment: .leading) {
        //TODO: - 측청 모듈에서 바른 자세 유지 시간 구하기
        makeDetailInfo(
          title: "바른 자세 시간",
          value: TimeFormatter.toClockString(from: store.activity.activityDuration),
          color: color
        )
        
        Divider()
          .padding(.bottom, 8)
        
        //TODO: - 1분 미만 미노출?
        makeDetailInfo(
          title: "분당 눈 깜빡임 수",
          value: "\(store.activity.blinkCount)",
          color: SharedDesignSystemAsset.blue.swiftUIColor
        )
      }
    }
    .padding(.all, 16)
    .background(SharedDesignSystemAsset.gray300.swiftUIColor)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  func makeDetailInfo(
    title: String,
    value: String,
    color: Color
  ) -> some View {
    VStack(alignment: .leading, spacing: 6) {
      Text(title)
        .modifier(GamtanFont(font: .bold, size: 14))
        .foregroundColor(
          SharedDesignSystemAsset.gray700.swiftUIColor
        )
      
      Text(value)
        .modifier(GamtanFont(font: .bold, size: 24))
        .foregroundColor(color)
    }
  }
  
  var timeLapseTitle: some View {
    Text("타입랩스")
      .modifier(GamtanFont(font: .bold, size: 20))
      .foregroundColor(
        SharedDesignSystemAsset.gray700.swiftUIColor
      )
  }
  
  var timeLapseGridView: some View {
    HStack(spacing: 0) {
      LazyVGrid(columns: columns) {
        ForEach((store.thumbnail.indices), id: \.self) { index in
          Button {
            store.send(.thumbnailTapped(index))
          } label: {
            photoView(store.thumbnail[index])
          }
        }
      }
    }
    .padding(.all, 16)
    .background(SharedDesignSystemAsset.gray300.swiftUIColor)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  func photoView(_ data: Data) -> some View {
    return Image(uiImage: UIImage(data: data) ?? UIImage())
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 100, height: 100, alignment: .center)
      .clipped()
      .cornerRadius(15)
  }
}
