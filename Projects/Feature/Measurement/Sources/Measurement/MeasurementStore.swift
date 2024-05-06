//
//  MeasurementStore.swift
//  FeatureMeasurement
//
//  Created by 황제하 on 4/2/24.
//

import Foundation

import ComposableArchitecture

import FeatureMeasurementInterface
import DomainActivity
import DomainActivityInterface
import CoreImageProcss
import SharedUtil

extension MeasurementStore {
  public init() {
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.activityClient) var activityClient
    @Dependency(\.imageProcess) var imageProcess
    
    let reducer: Reduce<State, Action> = Reduce { state, action in
      switch action {
        case let .faceTracking(action):
          switch action {
            case let .changedFaceCenter(center):
              state.faceCenter = center
              return .none
              
            case let .eyeBlink(value):
              if value == 0 {
                state.isEyeClose = true
              } else {
                if state.isEyeClose == true {
                  state.eyeBlinkCount += 1
                }
                state.isEyeClose = false
              }
              
              return .none
            case .snapshot:
              return .none
            case let .saveImage(image):
              guard let image else {
                return .none
              }
              
              let name = DateUtil.shared.toNow(from: .now)
              ImageCache.shared.saveImageToDiskCache(
                image,
                forKey: name
              )
              
              return .run { [image, name] send in
                let data = await imageProcess.toDataWithDownSample(
                  image, 100
                )
                guard let data else {
                  return ()
                }
                let timeLapse = Timelapse(
                  thumbnail: data,
                  name: name
                )
                await send(.saveTimeLapseResponse(timeLapse))
              }
          }
          
        case .appear:
          return .send(.initialTimerStart)
          
        case .initialTimerStart:
          state.isInitailing = true
          return .run { send in
            for await _ in clock.timer(interval: .seconds(1)) {
              await send(.initialTimerTicked)
            }
          }
          .cancellable(id: CancelID.timer)
          
        case .initialTimerTicked:
          if state.initialTimerCount == 0 {
            state.isInitailing = false
            state.initialFaceCenter = state.faceCenter
            return .concatenate([
              .send(.start),
              .cancel(id: CancelID.timer)
            ])
          }
          
          state.initialTimerCount -= 1
          return .none
          
        case .start:
          return .run { send in
            for await _ in clock.timer(interval: .seconds(1)) {
              await send(.timerTicked)
              await send(.faceDistance)
            }
          }
          .cancellable(id: CancelID.timer)
          
        case .timerTicked:
          state.time += 1
          state.timeString = TimeFormatter.toClockString(from: state.time)
          
          if state.time % 3 == 0 {
            return .send(.faceTracking(.snapshot))
          }
          
          return .none
          
        case .faceDistance:
          guard let center = state.faceCenter,
                let initialCenter = state.initialFaceCenter
          else {
            return .none
          }
          //TODO: - 범위 조절 기능 추가(우측 화면 swipe)
          if initialCenter.distance(to: center) > 0.1 {
            state.isWarning = true
          } else {
            state.isWarning = false
          }
          
          return .none
          
        case let .saveTimeLapseResponse(value):
          state.timeLapseData.append(value)
          
          return .none
          
        case .closeButtonTapped:
          do {
            let activity = Activity(
              title: "테스트",
              measurementMode: state.mode,
              activityDuration: state.time,
              blinkCount: state.eyeBlinkCount,
              timelapse: state.timeLapseData
            )
            try activityClient.add(activity)
          } catch { }
          return .concatenate([
            .cancel(id: CancelID.timer),
            .none
          ])
          
        default:
          return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
