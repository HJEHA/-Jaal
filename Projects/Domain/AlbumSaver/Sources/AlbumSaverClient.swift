//
//  AlbumSaverClient.swift
//  DomainAlbumSaver
//
//  Created by 황제하 on 4/24/24.
//

import UIKit

import ComposableArchitecture

import DomainAlbumSaverInterface
import SharedUtil
import SharedDesignSystem

extension AlbumSaverClient: DependencyKey {
  public static let liveValue = AlbumSaverClient(
    savePhoto: { image in
      if PermissionManager.checkPhotoPermission() == true {
        throw AlbumSaverError.denied
      }
      
      let watermarkImage = image.overlayWith(
        image: SharedDesignSystemAsset.watermark.image
      )
      
      let completion = ImageSaver()
      return try await withCheckedThrowingContinuation { continuation in
        completion.continuation = continuation
        
        UIImageWriteToSavedPhotosAlbum(
          watermarkImage,
          completion,
          #selector(ImageSaver.image(_:didFinishSavingWithError:contextInfo:)),
          nil
        )
      }
    },
    saveVideo: { keys in
      if PermissionManager.checkPhotoPermission() == true {
        throw AlbumSaverError.denied
      }
      
      let imagePaths = keys
      let imageSize = ImageCache.shared.loadImageFromDiskCache(forKey: keys[0])?.size ?? .zero
      
      let outputSetting = MovieOutputSettings(size: imageSize)
      let movieMaker = MovieMaker(outputSettings: outputSetting)
      movieMaker.start()
      
      for i in 0..<imagePaths.count {
        guard let image = ImageCache.shared.loadImageFromDiskCache(
          forKey: imagePaths[i]
        ) else { continue }
        
        let watermarkImage = image.overlayWith(
          image: SharedDesignSystemAsset.watermark.image
        )
        
        movieMaker.make(watermarkImage)
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
