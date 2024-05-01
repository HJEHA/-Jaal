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
  
  public init(store: StoreOf<OnboardingAvatarStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(alignment: .center) {
      title
      
      HStack(alignment: .bottom) {
        
        Spacer()
        
        avatar
        
        shuffle
          .padding(.bottom, 8)
      }
      .padding(.horizontal, 16)
      
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
      Text(store.isEdit ? "아바타 변경" : "아바타 설정")
        .modifier(GamtanFont(font: .bold, size: 24))
      
      Spacer()
    }
    .padding(.vertical, store.isEdit ? 24 : 8)
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
      
      Group {
        Image(uiImage: Heads.allCases[store.headID].image)
          .resizable()
          .colorMultiply(
            Color(uiColor: SkinColors.allCases[store.skinID].color)
          )
          .frame(width: 100, height: 100)
        
        Image(uiImage: Faces.allCases[store.faceID].image)
          .resizable()
          .frame(width: 100, height: 100)
      }
      .scaleEffect(x: 4, y: 4, anchor: .center)
      .padding(.top, 50)
      .padding(.leading, 20)
    }
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  private var shuffle: some View {
    Button {
      store.send(.shuffleButtonTapped, animation: .easeInOut)
    } label: {
      HStack {
        Image(systemName: "shuffle")
          .resizable()
          .foregroundColor(
            SharedDesignSystemAsset.orange.swiftUIColor
          )
          .frame(width: 16, height: 16)
        
        Text("무작위")
          .modifier(GamtanFont(font: .bold, size: 16))
          .foregroundColor(
            SharedDesignSystemAsset.orange.swiftUIColor
          )
      }
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
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 16) {
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
            .id(index)
          }
        }
        .padding(.horizontal, 16)
      }
      .onChange(of: store.isScrollCenter, { _, newValue in
        guard newValue == true else {
          return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          proxy.scrollTo(store.skinID, anchor: .center)
          store.isScrollCenter = false
        }
      })
    }
  }
  
  private var headSelecter: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 16) {
          ForEach(0..<Heads.allCases.count, id: \.self) { index in
            Button {
              store.headID = index
            } label: {
              ZStack {
                Color.white
                  .clipShape(RoundedRectangle(cornerRadius: 12))
                  .padding(.vertical, 12)
                  .padding(.horizontal, 6)
                
                Image(uiImage: Heads.allCases[index].image)
                  .resizable()
                  .scaleEffect(x: 2, y: 2, anchor: .center)
                  .frame(width: 100, height: 100)
                  .padding(.top, 22)
                  .padding(.leading, 10)
              }
              .frame(width: 100, height: 100)
              .foregroundColor(.clear)
              .overlay {
                if index == store.headID {
                  RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.orange, lineWidth: 4)
                }
              }
            }
            .id(index)
          }
        }
        .padding(.horizontal, 16)
      }
      .onChange(of: store.isScrollCenter, { _, newValue in
        guard newValue == true else {
          return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          proxy.scrollTo(store.headID, anchor: .center)
          store.isScrollCenter = false
        }
      })
    }
  }
  
  private var faceSelecter: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 16) {
          ForEach(0..<Faces.allCases.count, id: \.self) { index in
            Button {
              store.faceID = index
            } label: {
              ZStack {
                Color.white
                  .clipShape(RoundedRectangle(cornerRadius: 12))
                  .padding(.vertical, 12)
                  .padding(.horizontal, 6)
                
                Image(uiImage: Faces.allCases[index].image)
                  .resizable()
                  .scaleEffect(x: 3.6, y: 3.6, anchor: .center)
                  .frame(width: 100, height: 100)
                  .padding(.top, 16)
                  .padding(.trailing, 4)
              }
              .frame(width: 100, height: 100)
              .foregroundColor(.clear)
              .overlay {
                if index == store.faceID {
                  RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.orange, lineWidth: 4)
                }
              }
            }
            .id(index)
          }
        }
        .padding(.horizontal, 16)
      }
      .onChange(of: store.isScrollCenter, { _, newValue in
        guard newValue == true else {
          return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          proxy.scrollTo(store.faceID, anchor: .center)
          store.isScrollCenter = false
        }
      })
    }
  }
  
  private var goToMain: some View {
    Button(action: {
      store.send(.doneButtonTapped)
    }, label: {
      ZStack {
        RoundedRectangle(cornerRadius: 16)
          .foregroundColor(
            SharedDesignSystemAsset.beige.swiftUIColor
          )
        
        Text(store.isEdit ? "변경하기" : "시작하기")
          .modifier(GamtanFont(font: .bold, size: 18))
          .foregroundColor(
            SharedDesignSystemAsset.orange.swiftUIColor
          )
        
      }
      .frame(height: 56)
    })
  }
}
