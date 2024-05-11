//
//  FaceTrackingSharedState.swift
//  FeatureMeasurementInterface
//
//  Created by 황제하 on 5/11/24.
//

import Foundation

public struct FaceTrackingSharedState: Equatable {
  public var faceCenter: SIMD3<Float>?
  public var isEyeClose: Bool = true
}
