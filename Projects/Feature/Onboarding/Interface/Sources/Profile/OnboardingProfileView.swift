//
//  OnboardingProfileView.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/25/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct OnboardingProfileView: View {
  @Bindable private var store: StoreOf<OnboardingProfileStore>
  @FocusState private var isFocused: Bool
  
  public init(store: StoreOf<OnboardingProfileStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      title
      
      JaalTextField(
        isFocused: $isFocused,
        text: $store.name
      )
      .setTitleText("이름")
      .setMaxCount(8)
      .setPlaceHolderText("8자 이내로 입력해주세요.")
      .setErrorText("최대 8자까지 쓸 수 있어요.")
      .focused($isFocused)
      .padding(.top, 24)
      .padding(.horizontal, 16)
      
      Spacer()
      
      goToAvatar
        .padding(.bottom, isFocused ? 0 : 16)
        .padding(.horizontal, isFocused ? 0 : 16)
    }
    .background(SharedDesignSystemAsset.gray100.swiftUIColor)
    .toolbar(.hidden, for: .navigationBar)
    .onAppear {
      store.send(.onAppear)
    }
    .onTapGesture {
      isFocused = false
    }
  }
}

extension OnboardingProfileView {
  private var title: some View {
    HStack {
      Text(store.isEdit ? "프로필 변경" : "프로필 설정")
        .modifier(GamtanFont(font: .bold, size: 24))
      
      Spacer()
    }
    .padding(.vertical, store.isEdit ? 24 : 8)
    .padding(.horizontal, 16)
  }
  
  private var goToAvatar: some View {
    Button(action: {
      store.send(.doneButtonTapped)
    }, label: {
      ZStack {
        RoundedRectangle(cornerRadius: isFocused ? 0 : 16)
          .foregroundColor(
            SharedDesignSystemAsset.beige.swiftUIColor
          )
        
        HStack {
          if store.isEdit == false {
            SharedDesignSystemAsset.oops.swiftUIImage
              .resizable()
              .frame(width: 30, height: 30)
          }
            
          Text(store.isEdit ? "변경하기" : "아바타 설정")
            .modifier(GamtanFont(font: .bold, size: 18))
            .foregroundColor(
              SharedDesignSystemAsset.orange.swiftUIColor
            )
        }
        
        if store.doneButtonDisabled {
          RoundedRectangle(cornerRadius: isFocused ? 0 : 16)
            .foregroundColor(
              SharedDesignSystemAsset.gray100.swiftUIColor
            )
            .opacity(0.5)
        }
      }
      .frame(height: 56)
    })
    .disabled(store.doneButtonDisabled)
  }
}

