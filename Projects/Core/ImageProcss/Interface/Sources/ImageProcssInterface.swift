//
//  ImageProcssInterface.swift
//  CoreImageProcss
//
//  Created by 황제하 on 4/16/24.
//

import SwiftUI

import ComposableArchitecture

public struct ImageProcess {
  public var toDataWithDownSample: @Sendable (UIImage, CGFloat) async -> Data?
  
  public init(
    toDataWithDownSample: @Sendable @escaping (UIImage, CGFloat) -> Data?
  ) {
    self.toDataWithDownSample = toDataWithDownSample
  }
}

extension ImageProcess: TestDependencyKey {
  public static var testValue = Self(
    toDataWithDownSample: unimplemented("\(Self.self).toDataWithDownSample")
  )
}
