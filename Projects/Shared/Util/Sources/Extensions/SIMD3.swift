//
//  SIMD3.swift
//  SharedUtil
//
//  Created by 황제하 on 4/4/24.
//

import simd

public extension SIMD3<Float> {
  func distance(to point: SIMD3<Float>) -> Float {
    let deltaX = self.x - point.x
    let deltaY = self.y - point.y
    let deltaZ = self.z - point.z
    let distance = sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ)
    
    return distance
  }
}
