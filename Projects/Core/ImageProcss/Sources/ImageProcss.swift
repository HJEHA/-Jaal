//
//  ImageProcss.swift
//  CoreImageProcss
//
//  Created by 황제하 on 4/16/24.
//

import SwiftUI

import ComposableArchitecture

import CoreImageProcssInterface

extension ImageProcess: DependencyKey {
  public static let liveValue = ImageProcess(
    toDataWithDownSample: { (image, newWidth) in
      let scale = newWidth / image.size.width
      let newHeight = image.size.height * scale
      
      let size = CGSize(width: newWidth, height: newHeight)
      let render = UIGraphicsImageRenderer(size: size)
      let downSampledImage = render.image { context in
        image.draw(in: CGRect(origin: .zero, size: size))
      }
      
      return downSampledImage.pngData()
    }
  )
}

public extension DependencyValues {
  var imageProcess: ImageProcess {
    get { self[ImageProcess.self] }
    set { self[ImageProcess.self] = newValue }
  }
}
