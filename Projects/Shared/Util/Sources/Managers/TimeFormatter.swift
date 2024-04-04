//
//  TimeFormatter.swift
//  SharedUtil
//
//  Created by 황제하 on 4/01/24.
//

import Foundation

public struct TimeFormatter {
  public static func toClockString(from second: Int) -> String {
    let m = String(format: "%02d", (second % 3600) / 60)
    let s = String(format: "%02d", (second % 3600) % 60)
    
    return "\(m):\(s)"
  }
}
