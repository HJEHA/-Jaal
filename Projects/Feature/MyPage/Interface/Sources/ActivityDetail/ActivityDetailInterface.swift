//
//  ActivityDetailInterface.swift
//  FeatureMyPageInterface
//
//  Created by 황제하 on 4/15/24.
//

import Foundation

import ComposableArchitecture

import DomainActivityInterface
import SharedUtil

@Reducer
public struct ActivityDetailStore {
  private let reducer: Reduce<State, Action>
  private let photoDetail: PhotoDetailStore
  
  public init(
    reducer: Reduce<State, Action>,
    photoDetail: PhotoDetailStore
  ) {
    self.reducer = reducer
    self.photoDetail = photoDetail
  }
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var photoDetail: PhotoDetailStore.State?
    
    public var activity: Activity
    public var sortedTimeLapse: [Timelapse] = []
    
    var navigationBartitle: String {
      return "\(DateUtil.shared.toMonthDay(from: activity.date)) (\(DateUtil.shared.toDayOfWeek(from: activity.date)))"
    }
    
    var dateRange: String {
      return activity.date.dateRangeString(
        minusSeconds: TimeInterval(activity.activityDuration)
      )
    }
    
    var thumbnail: [Data] {
      return sortedTimeLapse.map { $0.thumbnail }
    }
    
    public init(activity: Activity) {
      self.activity = activity
    }
  }
  
  public enum Action: Equatable {
    case photoDetail(PresentationAction<PhotoDetailStore.Action>)
    
    case onAppear
    case saveButtonTapped
    
    case thumbnailTapped(Int)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
      .ifLet(\.$photoDetail, action: /Action.photoDetail) {
        photoDetail
      }
  }
}
