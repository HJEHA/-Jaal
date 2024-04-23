//
//  ImageSaver.swift
//  SharedUtil
//
//  Created by 황제하 on 4/19/24.
//

import UIKit
import Photos

public class ImageSaver: NSObject {
  public static let shared: ImageSaver = ImageSaver()
  
  private override init() { }
  
  private var isPermissionDenied = false
  private var imageSavedHandler: (() -> Void)?
  private var imageSavedErrorHandler: (() -> Void)?
  
  public func saveImage(
    _ image: UIImage,
    handler: (() -> Void)? = nil,
    errorHandler: (() -> Void)? = nil
  ) {
    imageSavedHandler = handler
    imageSavedErrorHandler = errorHandler
    
    isPermissionDenied = checkPhotoPermission()
    
    UIImageWriteToSavedPhotosAlbum(
      image,
      self,
      #selector(imageSaved(image:didFinishSavingWithError:contextInfo:)),
      nil
    )
  }
  
  @objc func imageSaved(
    image: UIImage,
    didFinishSavingWithError error: Error?,
    contextInfo: UnsafeRawPointer
  ) {
    if let error = error {
      if isPermissionDenied {
        imageSavedErrorHandler?()
      }
    } else {
      imageSavedHandler?()
    }
  }
  
  private func checkPhotoPermission() -> Bool {
    var status: PHAuthorizationStatus = .notDetermined
    status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
    return status == .denied
  }
}
