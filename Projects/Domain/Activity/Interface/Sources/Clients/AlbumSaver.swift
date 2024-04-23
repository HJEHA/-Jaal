//
//  AlbumSaver.swift
//  DomainActivityInterface
//
//  Created by 황제하 on 4/23/24.
//

import UIKit
import AVFoundation
import Photos

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

extension AlbumSaverClient: DependencyKey {
  public static let liveValue = AlbumSaverClient(
    savePhoto: { image in
      let completion = UIImageWriteToSavedPhotosAlbumCompletion()
      return try await withCheckedThrowingContinuation { continuation in
        completion.continuation = continuation
        
        UIImageWriteToSavedPhotosAlbum(
          image,
          completion,
          #selector(UIImageWriteToSavedPhotosAlbumCompletion.image(_:didFinishSavingWithError:contextInfo:)),
          nil
        )
      }
    },
    saveVideo: { keys in
      let imagePaths = keys
      let imageSize = ImageCache.shared.loadImageFromDiskCache(forKey: keys[0])?.size ?? .zero
      
      let outputSetting = MovieOutputSettings(size: imageSize)
      let movieMaker = MovieMaker(outputSettings: outputSetting)
      movieMaker.start()
      
      for i in 0..<imagePaths.count {
        guard let image = ImageCache.shared.loadImageFromDiskCache(
          forKey: imagePaths[i]
        ) else { continue }
        
        movieMaker.make(image)
      }
      
      return try await withCheckedThrowingContinuation { continuation in
        movieMaker.continuation = continuation
        
        movieMaker.finish()
      }
    }
  )
}

public extension DependencyValues {
  var albumSaverClient: AlbumSaverClient {
    get { self[AlbumSaverClient.self] }
    set { self[AlbumSaverClient.self] = newValue }
  }
}

extension AlbumSaverClient: TestDependencyKey {
  public static var testValue = Self(
    savePhoto: unimplemented("\(Self.self).savePhoto"),
    saveVideo: unimplemented("\(Self.self).saveVideo")
  )
}

private final class UIImageWriteToSavedPhotosAlbumCompletion: NSObject {
  var continuation: CheckedContinuation<Bool, any Error>?
  @objc func image(
    _ image: UIImage,
    didFinishSavingWithError error: Error?,
    contextInfo: UnsafeRawPointer
  ) {
    if let error = error {
      continuation?.resume(throwing: error)
    } else {
      continuation?.resume(returning: true)
    }
  }
}

