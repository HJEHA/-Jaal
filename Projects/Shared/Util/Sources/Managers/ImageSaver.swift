//
//  ImageSaver.swift
//  SharedUtil
//
//  Created by 황제하 on 4/19/24.
//

import UIKit
import Photos

public final class ImageSaver: NSObject {
  public var continuation: CheckedContinuation<Bool, any Error>?
  @objc public func image(
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
  
  public func checkPhotoPermission() -> Bool {
    var status: PHAuthorizationStatus = .notDetermined
    status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
    return status == .denied
  }
}
