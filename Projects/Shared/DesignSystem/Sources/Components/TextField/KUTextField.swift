//
//  KUTextField.swift
//  SharedDesignSystem
//
//  Created by 황제하 on 4/25/24.
//

import SwiftUI

public struct KUTextField: View {
  
  private var isFocused: FocusState<Bool>.Binding
  private var text: Binding<String>
  private var titleText: String?
  private var placeHolderText: String = ""
  private var errorText : String?
  private var maxCount: Int
  
  
  private var defaultTextColor =  SharedDesignSystemAsset.gray800.swiftUIColor
  private var defaultTitleColor =  SharedDesignSystemAsset.gray800.swiftUIColor
  private var defaultPlaceHolderTextColor =  SharedDesignSystemAsset.gray500.swiftUIColor
  private var defaultBackgroundColor =  SharedDesignSystemAsset.gray500.swiftUIColor
  private var defaultBorderColor =  SharedDesignSystemAsset.gray500.swiftUIColor
  private var focusedBorderColor =  SharedDesignSystemAsset.blue.swiftUIColor
  
  public init(
    isFocused: FocusState<Bool>.Binding,
    text: Binding<String>, 
    maxCount: Int = 15
  ) {
    self.isFocused = isFocused
    self.text = text
    self.maxCount = maxCount
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      
      HStack(spacing: 12) {
        if let titleText {
          Text(titleText)
            .modifier(GamtanFont(font: .bold, size: 16))
            .foregroundColor(SharedDesignSystemAsset.gray800.swiftUIColor)
        }
        
        if let errorText, text.wrappedValue.count > maxCount {
          Text(errorText)
            .modifier(GamtanFont(font: .regular, size: 14))
            .foregroundColor(.red)
        }
      }
      
      ZStack(alignment: .trailing) {
        VStack(spacing: 0){
          HStack(spacing: 0){
            TextField("", text: text)
              .submitLabel(.done)
              .modifier(GamtanFont(font: .bold, size: 16))
              .placeholder(
                when: text.wrappedValue.isEmpty,
                placeholder: {
                  Text(placeHolderText)
                    .foregroundColor(SharedDesignSystemAsset.gray500.swiftUIColor)
                    .modifier(GamtanFont(font: .bold, size: 16))
                }
              )
              .frame(maxWidth: .infinity)
              .frame(height: 50)
              .foregroundColor(SharedDesignSystemAsset.gray800.swiftUIColor)
              .padding(.horizontal, 20)
              .padding(.trailing, 40)
              .background(Color.clear)
          }
          .background(
            RoundedRectangle(cornerRadius: 12)
              .stroke(getBorderColor(), lineWidth: 1)
          )
        }
        
        Group {
          if isFocused.wrappedValue {
            Button {
              self.text.wrappedValue = ""
            } label: {
              Image(systemName: "xmark.circle.fill")
                .foregroundColor(SharedDesignSystemAsset.gray300.swiftUIColor)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
          } else {
            Text("\(text.wrappedValue.count)/\(maxCount)")
              .modifier(GamtanFont(font: .bold, size: 16))
              .foregroundColor(text.wrappedValue.count > maxCount ? .red : SharedDesignSystemAsset.gray500.swiftUIColor)
          }
        }
        .padding(.trailing)
      }
    }
    
  }
  
}
public extension KUTextField {
  
  func setTitleText(_ titleText: String) -> Self {
    var copy = self
    copy.titleText = titleText
    return copy
  }
  
  func setPlaceHolderText(_ placeHolderText: String) -> Self {
    var copy = self
    copy.placeHolderText = placeHolderText
    return copy
  }
  
  func setErrorText(_ errorText: String) -> Self {
    var copy = self
    copy.errorText = errorText
    return copy
  }
  
  func setMaxCount(_ count: Int) -> Self {
    var copy = self
    copy.maxCount = count
    return copy
  }
  
  private func getBorderColor() -> Color {
    if maxCount < text.wrappedValue.count {
      return Color.red
    }
    
    if isFocused.wrappedValue {
      return focusedBorderColor
    } else {
      return defaultBorderColor
    }
  }
}

extension View {
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content
  ) -> some View {
    ZStack(alignment: alignment) {
      placeholder()
        .opacity(shouldShow ? 1 : 0)
      self
    }
    .allowsHitTesting(true)
  }
}
