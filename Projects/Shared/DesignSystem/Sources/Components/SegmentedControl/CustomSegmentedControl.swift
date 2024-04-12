//
//  CustomSegmentedControl.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/12/24.
//

import SwiftUI

public struct CustomSegmentedControl: View {
  
  @Binding public var selection: Int
  @State private var isAnimating = false
  
  private let size: CGSize
  private let segmentLabels: [String]
  private let segmentPadding: CGFloat = 3
  
  public var body: some View {
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 10)
        .frame(width: size.width, height: size.height)
        .foregroundColor(.gray)
        .opacity(0.2)
      
      HStack(spacing: 0) {
        ForEach(0..<segmentLabels.count, id: \.self) { idx in
          if idx < (segmentLabels.count - 1) {
            customDivider(
              offset: (segmentWidth(size) - 0.5) * CGFloat(idx + 1),
              opacity: idx == selection - 1 || idx == selection ? 0.0 : 1.0
            )
          }
        }
      }
      .animation(
        .easeOut(duration: 0.3),
        value: isAnimating
      )
      
      RoundedRectangle(cornerRadius: 10)
        .frame(
          width: segmentWidth(size) - (segmentPadding * 2),
          height: size.height - (segmentPadding * 2)
        )
        .foregroundColor(
          SharedDesignSystemAsset.blue.swiftUIColor
        )
        .offset(x: calculateSegmentOffset(size) + segmentPadding)
        .animation(
          .easeInOut(duration: 0.3),
          value: isAnimating
        )
      
      HStack(spacing: 0) {
        ForEach(0..<segmentLabels.count, id: \.self) { idx in
          SegmentLabel(
            title: segmentLabels[idx],
            width: segmentWidth(size),
            textColor: selection == idx
            ? Color.white 
            : SharedDesignSystemAsset.gray700.swiftUIColor
          )
          .onTapGesture {
            selection = idx
            isAnimating.toggle()
          }
        }
      }
    }
  }
  
  public init(
    selection: Binding<Int>,
    size: CGSize,
    segmentLabels: [String]
  ) {
    self._selection = selection
    self.size = size
    self.segmentLabels = segmentLabels
  }
  
  private func segmentWidth(_ mainSize: CGSize) -> CGFloat {
    var width = (mainSize.width / CGFloat(segmentLabels.count))
    if width < 0 {
      width = 0
    }
    return width
  }
  
  private func calculateSegmentOffset(_ mainSize: CGSize) -> CGFloat {
    segmentWidth(mainSize) * CGFloat(selection)
  }
  
  private func customDivider(
    offset: CGFloat,
    opacity: Double
  ) -> some View {
    Divider()
      .background(Color.black)
      .frame(height: size.height * 0.5) // The height of the divider
      .offset(x: offset)
      .opacity(opacity)
  }
}

fileprivate struct SegmentLabel: View {
  
  let title: String
  let width: CGFloat
  let textColor: Color
  
  var body: some View {
    Text(title)
      .multilineTextAlignment(.center)
      .fixedSize(horizontal: false, vertical: false)
      .modifier(GamtanFont(font: .bold, size: 20))
      .foregroundColor(textColor)
      .frame(width: width)
      .contentShape(Rectangle())
  }
}
