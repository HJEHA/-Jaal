//
//  OnboardingAvatarView.swift
//  FeatureOnboardingInterface
//
//  Created by 황제하 on 4/26/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct OnboardingAvatarView: View {
  @Bindable private var store: StoreOf<OnboardingAvatarStore>
  
  private let imageRate = 0.3
  
  private let headImageRate = 0.12
  private let faceImageRate = 0.24
  private let accessoryImageRate = 0.2
  
  public init(store: StoreOf<OnboardingAvatarStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(alignment: .center) {
      title
      
      avatar
      
      selecters
      
      Spacer()
      
      goToMain
        .padding(.bottom, 16)
        .padding(.horizontal, 16)
    }
    .background(SharedDesignSystemAsset.gray100.swiftUIColor)
    .toolbar(.hidden, for: .navigationBar)
    .onAppear {
      store.send(.onAppear)
    }
  }
}

extension OnboardingAvatarView {
  private var title: some View {
    HStack {
      Text("아바타")
        .modifier(GamtanFont(font: .bold, size: 24))
      
      Spacer()
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 16)
  }
  
  private var avatar: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16)
        .frame(width: 200, height: 200)
        .foregroundColor(.white)
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .stroke(
              SharedDesignSystemAsset.orange.swiftUIColor,
              lineWidth: 3
            )
        )
      
      Image(uiImage: Heads.allCases[store.headID].image)
        .resizable()
        .colorMultiply(
          Color(uiColor: SkinColors.allCases[store.skinID].color)
        )
        .frame(width: 788 * imageRate, height: 788 * imageRate)
      
      Image(uiImage: Faces.allCases[store.faceID].image)
        .resizable()
        .frame(width: 284 * imageRate, height: 284 * imageRate)
        .padding(.top, 36)
        .padding(.leading, 34)
    }
  }
  
  private var selecters: some View {
    VStack {
      skinColorSelecter
      
      headSelecter
      
      faceSelecter
    }
  }
  
  private var skinColorSelecter: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 16) {
        ForEach(0..<SkinColors.allCases.count, id: \.self) { index in
          Button {
            store.skinID = index
          } label: {
            Color(uiColor: SkinColors.allCases[index].color)
              .frame(width: 100, height: 100)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .overlay {
                if index == store.skinID {
                  RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.orange, lineWidth: 4)
                }
              }
          }
        }
      }
      .padding(.horizontal, 16)
    }
  }
  
  private var headSelecter: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 16) {
        ForEach(0..<Heads.allCases.count, id: \.self) { index in
          Button {
            store.headID = index
          } label: {
            ZStack {
              RoundedRectangle(cornerRadius: 12)
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .overlay {
                  if index == store.headID {
                    RoundedRectangle(cornerRadius: 12)
                      .strokeBorder(Color.orange, lineWidth: 4)
                  }
                }
              
              Image(uiImage: Heads.allCases[index].image)
                .resizable()
                .frame(width: 788 * headImageRate, height: 788 * headImageRate)
            }
          }
        }
      }
      .padding(.horizontal, 16)
    }
  }
  
  private var faceSelecter: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 16) {
        ForEach(0..<Faces.allCases.count, id: \.self) { index in
          Button {
            store.faceID = index
          } label: {
            ZStack {
              RoundedRectangle(cornerRadius: 12)
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .overlay {
                  if index == store.faceID {
                    RoundedRectangle(cornerRadius: 12)
                      .strokeBorder(Color.orange, lineWidth: 4)
                  }
                }
              
              Image(uiImage: Faces.allCases[index].image)
                .resizable()
                .frame(width: 788 * headImageRate, height: 788 * headImageRate)
            }
          }
        }
      }
      .padding(.horizontal, 16)
    }
  }
  
  private var goToMain: some View {
    Button(action: {
      store.send(.goToMain)
    }, label: {
      ZStack {
        RoundedRectangle(cornerRadius: 16)
          .foregroundColor(
            SharedDesignSystemAsset.beige.swiftUIColor
          )
        
        Text("시작하기")
          .modifier(GamtanFont(font: .bold, size: 18))
          .foregroundColor(
            SharedDesignSystemAsset.orange.swiftUIColor
          )
        
      }
      .frame(height: 56)
    })
  }
}
