//
//  UIImage.swift
//  SharedUtil
//
//  Created by 황제하 on 5/3/24.
//

import UIKit

public extension UIImage {
  func overlayWith(image: UIImage) -> UIImage {
    let newSize = CGSize(
      width: size.width,
      height: size.height
    )
    UIGraphicsBeginImageContextWithOptions(
      newSize,
      false,
      0.0
    )
    
    draw(
      in: CGRect(
        origin: CGPoint.zero,
        size: size
      )
    )
    image.draw(
      in: CGRect(
        origin: CGPoint(x: size.width - 400, y: size.height - 170),
        size: image.size
      )
    )
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return newImage
  }
}
