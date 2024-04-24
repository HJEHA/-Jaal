//
//  PermissionManager.swift
//  SharedUtil
//
//  Created by 황제하 on 4/24/24.
//

import Foundation
import Photos

public struct PermissionManager {
  public static func checkPhotoPermission() -> Bool {
    var status: PHAuthorizationStatus = .notDetermined
    status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
    return status == .denied
  }
}
