//
//  AlbumSaverClient.swift
//  DomainAlbumSaverInterface
//
//  Created by 황제하 on 4/24/24.
//

import UIKit

import ComposableArchitecture

import SharedUtil

public struct AlbumSaverClient {
  public var savePhoto: @Sendable (_ image: UIImage) async throws -> Bool
  public var saveVideo: @Sendable (_ keys: [String]) async throws -> Bool
  
  public init(
    savePhoto: @escaping @Sendable (_: UIImage) async throws -> Bool,
    saveVideo: @escaping @Sendable (_: [String]) async throws -> Bool
  ) {
    self.savePhoto = savePhoto
    self.saveVideo = saveVideo
  }
}

extension AlbumSaverClient: TestDependencyKey {
  public static var testValue = Self(
    savePhoto: unimplemented("\(Self.self).savePhoto"),
    saveVideo: unimplemented("\(Self.self).saveVideo")
  )
}
