//
//  UIDevice.swift
//  SharedUtil
//
//  Created by 황제하 on 5/22/24.
//

import UIKit
import AVFoundation

public extension UIDevice {
  static func vibrate() {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
  }
}
