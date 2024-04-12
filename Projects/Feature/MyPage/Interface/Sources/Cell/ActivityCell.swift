//
//  ActivityCell.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/12/24.
//

import SwiftUI

import DomainActivityInterface
import SharedDesignSystem
import SharedUtil

public struct ActivityCell: View {
  private let activity: Activity
  private var color: Color {
    switch activity.measurementMode {
      case .nomal:
        return SharedDesignSystemAsset.orange.swiftUIColor
      case .focus:
        return SharedDesignSystemAsset.red.swiftUIColor
    }
  }
  
  public init(activity: Activity) {
    self.activity = activity
  }
  
  public var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16)
        .frame(height: 80)
        .foregroundColor(
          SharedDesignSystemAsset.gray500.swiftUIColor
        )
        .opacity(0.2)
      
      
      HStack {
        makeIcon(activity.measurementMode)
          .padding(.leading, 16)
          .padding(.trailing, 6)
          .padding(.vertical, 10)
        
        VStack(alignment: .leading) {
          title
          Spacer()
          HStack(alignment: .bottom) {
            duration
            
            Spacer()
            
            dateTime
              .padding(.horizontal, 16)
          }
        }
        .padding(.vertical, 20)
      }
    }
    .padding(.horizontal, 16)
  }
}

extension ActivityCell {
  func makeIcon(_ mode: MeasurementMode) -> some View {
    let icon: Image
    
    switch mode {
      case .nomal:
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
      .frame(width: 60, height: 60)
      .clipShape(Circle())
      
      icon
        .renderingMode(.template)
        .resizable()
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
    }
  }
  
  var title: some View {
    Text(activity.title)
      .modifier(GamtanFont(font: .bold, size: 14))
      .foregroundColor(color)
  }
  
  var duration: some View {
    return Text(TimeFormatter.toClockString(from: activity.activityDuration))
      .modifier(GamtanFont(font: .bold, size: 30))
      .foregroundColor(color)
  }
  
  var dateTime: some View {
    return Text(DateUtil.shared.toYearMonthDayTime(from: activity.date))
      .modifier(GamtanFont(font: .bold, size: 14))
      .foregroundColor(color)
  }
}
