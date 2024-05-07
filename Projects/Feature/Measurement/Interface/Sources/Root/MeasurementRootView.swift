//
//  MeasurementView.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 4/1/24.
//

import SwiftUI

import ComposableArchitecture

import DomainActivityInterface
import SharedDesignSystem

public struct MeasurementRootView: View {
  @Bindable private var store: StoreOf<MeasurementRootStore>
  @FocusState private var isFocused: Bool
  
  public init(store: StoreOf<MeasurementRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        HStack {
          title
          
          Spacer()
          
          startButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        measurementTitle
          .padding(.leading, 20)
          .padding(.top, 12)
        
        JaalTextField(
          isFocused: $isFocused,
          text: $store.title
        )
        .setPlaceHolderText(store.placeholder)
        .focused($isFocused)
        .padding(.horizontal, 20)
        
        titleNotice
          .padding(.top, 4)
          .padding(.horizontal, 20)
        
        
        selectedMode
          .padding(.leading, 20)
          .padding(.top, 20)
        
        HStack {
          modeSelectButton(store, mode: .normal)
          
          modeSelectButton(store, mode: .focus)
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        
        if store.selectedMode == .focus {
          timerPicker
            .padding(.horizontal, 20)
            .padding(.top, 20)
          
          drowsinessTimerPicker
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        
        saveTimeLapse
          .padding(.horizontal, 20)
          .padding(.top, 20)
        
        Spacer()
      }
      .background(SharedDesignSystemAsset.gray100.swiftUIColor)
    }
    .onTapGesture {
      isFocused = false
    }
    .fullScreenCover(
      item: $store.scope(state: \.measurement, action: \.measurement)) { store in
        NavigationStack {
          MeasurementView(store: store)
        }
      }
  }
}

extension MeasurementRootView {
  private var title: some View {
    Text("측정하기")
      .modifier(GamtanFont(font: .bold, size: 24))
  }
  
  private var measurementTitle: some View {
    Text("제목")
      .modifier(GamtanFont(font: .bold, size: 20))
  }
  
  private var titleNotice: some View {
    HStack(spacing: 2) {
      SharedDesignSystemAsset.info.swiftUIImage
        .renderingMode(.template)
        .resizable()
        .frame(width: 14, height: 14)
      
      Text("입력이 없는 경우 이전에 입력했던 제목으로 저장됩니다.")
        .modifier(GamtanFont(font: .bold, size: 14))
    }
    .foregroundColor(
      SharedDesignSystemAsset.orange.swiftUIColor
    )
  }
  
  private var selectedMode: some View {
    Text("모드 선택")
      .modifier(GamtanFont(font: .bold, size: 20))
  }
  
  private var timerPicker: some View {
    HStack {
      Text("타이머 설정")
        .modifier(GamtanFont(font: .bold, size: 20))
      
      Spacer()
      
      Menu {
        Picker(selection: $store.selectedTimerPickerItem) {
          ForEach(store.timerPickerItems, id: \.self) {
            Text("\($0)분")
          }
        } label: {}
      } label: {
        Text("\(store.selectedTimerPickerItem)분")
          .modifier(GamtanFont(font: .bold, size: 18))
          .foregroundColor(
            SharedDesignSystemAsset.blue.swiftUIColor
          )
      }
    }
  }
  
  private var drowsinessTimerPicker: some View {
    HStack {
      Text("졸음방지 설정")
        .modifier(GamtanFont(font: .bold, size: 20))
      
      Spacer()
      
      Menu {
        Picker(selection: $store.selectedDrowsinessTimerPickerItem) {
          ForEach(store.timerPickerItems, id: \.self) {
            Text("\($0)초")
          }
        } label: {}
      } label: {
        Text("\(store.selectedDrowsinessTimerPickerItem)초")
          .modifier(GamtanFont(font: .bold, size: 18))
          .foregroundColor(
            SharedDesignSystemAsset.blue.swiftUIColor
          )
      }
    }
  }
  
  private var saveTimeLapse: some View {
    VStack(alignment: .leading) {
      Button {
        store.isSaveTimeLapse.toggle()
      } label: {
        HStack {
          Text("타입 랩스 저장")
            .modifier(GamtanFont(font: .bold, size: 20))
            .foregroundColor(.black)
          
          Spacer()
          
          Image(
            systemName: store.isSaveTimeLapse
            ? "checkmark.square"
            : "square"
          )
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundColor(
            SharedDesignSystemAsset.blue.swiftUIColor
          )
        }
      }
      
      HStack(spacing: 2) {
        SharedDesignSystemAsset.info.swiftUIImage
          .renderingMode(.template)
          .resizable()
          .frame(width: 14, height: 14)
        
        Text("이미지는 기기에만 저장됩니다.")
          .modifier(GamtanFont(font: .bold, size: 14))
      }
      .foregroundColor(
        SharedDesignSystemAsset.orange.swiftUIColor
      )
    }
  }
  
  private var startButton: some View {
    Button(action: {
      isFocused = false
      store.send(.startButtonTapped)
    }, label: {
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(
          SharedDesignSystemAsset.beige.swiftUIColor
        )
        .frame(width: 120, height: 56)
        .overlay(
          HStack {
            Image(
              uiImage: store.selectedMode == .normal
              ? SharedDesignSystemAsset.play.image
              : SharedDesignSystemAsset.flame.image
            )
            .renderingMode(.template)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(
              store.selectedMode == .normal
              ? SharedDesignSystemAsset.orange.swiftUIColor
              : SharedDesignSystemAsset.red.swiftUIColor
            )
            
            Text("측정 시작")
              .modifier(GamtanFont(font: .bold, size: 18))
              .foregroundColor(
                store.selectedMode == .normal
                ? SharedDesignSystemAsset.orange.swiftUIColor
                : SharedDesignSystemAsset.red.swiftUIColor
              )
          }
        )
    })
  }
  
  @ViewBuilder
  private func modeSelectButton(
    _ store: StoreOf<MeasurementRootStore>,
    mode: MeasurementMode
  ) -> some View {
    Button(action: {
      store.send(.modeButtonTapped(mode))
    }, label: {
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(
          store.selectedMode == mode
          ? SharedDesignSystemAsset.blue.swiftUIColor
          : SharedDesignSystemAsset.gray500.swiftUIColor
        )
        .frame(height: 64)
        .overlay(
          Text(mode.title)
            .modifier(GamtanFont(font: .bold, size: 24))
            .foregroundColor(.white)
        )
    })
  }
}
