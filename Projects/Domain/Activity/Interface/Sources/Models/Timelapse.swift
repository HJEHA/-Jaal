//
//  Timelapse.swift
//  DomainActivityInterface
//
//  Created by 황제하 on 4/17/24.
//

import Foundation
import SwiftData

@Model
public final class Timelapse: Identifiable {
  public var thumbnail: Data
  public var name: String
  
  public init(thumbnail: Data, name: String) {
    self.thumbnail = thumbnail
    self.name = name
  }
}

