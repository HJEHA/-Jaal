//
//  MovieMaker.swift
//  SharedUtil
//
//  Created by 황제하 on 4/23/24.
//

import AVFoundation
import UIKit
import Photos

public struct MovieOutputSettings {
  let size: CGSize
  var fps: Int
  var avCodecKey = AVVideoCodecType.h264
  var outputURL: URL
  
  public init(
    size: CGSize = .zero,
    fps: Int = 10,
    avCodecKey: AVVideoCodecType = .h264
  ) {
    self.size = size
    self.fps = fps
    self.avCodecKey = avCodecKey
    self.outputURL = {
      let documentsPath = NSSearchPathForDirectoriesInDomains(
        .documentDirectory,
        .userDomainMask,
        true
      )[0]
      let outputPath = "\(documentsPath)/\(DateUtil.shared.toNow(from: .now)).mp4"
      return URL(fileURLWithPath: outputPath)
    }()
  }
}


public class MovieMaker {
  public var continuation: CheckedContinuation<Bool, Error>?
  
  let outputSettings: MovieOutputSettings
  let assetWriter: AVAssetWriter
  let input: AVAssetWriterInput
  let adaptor: AVAssetWriterInputPixelBufferAdaptor!
  var currentFrame = 0
  
  public init(outputSettings: MovieOutputSettings) {
    self.outputSettings = outputSettings
    
    do {
      self.assetWriter = try AVAssetWriter(
        outputURL: outputSettings.outputURL,
        fileType: .mp4
      )
      let settings = [
        AVVideoCodecKey : AVVideoCodecType.h264,
        AVVideoWidthKey : NSNumber(value: Float(outputSettings.size.width)),
        AVVideoHeightKey : NSNumber(value: Float(outputSettings.size.height))
      ] as [String : Any]
      self.input = AVAssetWriterInput(
        mediaType: .video,
        outputSettings: settings
      )
    } catch {
      fatalError()
    }
    
    let pixelBufferAttributes = [
      kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB,
      kCVPixelBufferWidthKey as String: outputSettings.size.width,
      kCVPixelBufferHeightKey as String: outputSettings.size.height,
      kCVPixelBufferCGImageCompatibilityKey as String: true,
      kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
    ] as [String : Any]
    adaptor = AVAssetWriterInputPixelBufferAdaptor(
      assetWriterInput: self.input,
      sourcePixelBufferAttributes: pixelBufferAttributes
    )
    self.assetWriter.add(input)
  }
  
  public func start() {
    assetWriter.startWriting()
    assetWriter.startSession(atSourceTime: .zero)
  }
  
  public func make(_ image: UIImage) {
    guard let pixelBufferPool = adaptor.pixelBufferPool else { return }
    
    let presentationTime = CMTime(
      value: CMTimeValue(currentFrame),
      timescale: Int32(outputSettings.fps)
    )
    currentFrame += 1
    
    var pixelBuffer: CVPixelBuffer?
    CVPixelBufferPoolCreatePixelBuffer(
      kCFAllocatorDefault,
      pixelBufferPool,
      &pixelBuffer
    )
    guard let unwrappedPixelBuffer = pixelBuffer else { return }
    
    CVPixelBufferLockBaseAddress(unwrappedPixelBuffer, [])
    let pixelData = CVPixelBufferGetBaseAddress(unwrappedPixelBuffer)
    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let context = CGContext(
      data: pixelData,
      width: Int(outputSettings.size.width),
      height: Int(outputSettings.size.height),
      bitsPerComponent: 8,
      bytesPerRow: CVPixelBufferGetBytesPerRow(unwrappedPixelBuffer),
      space: rgbColorSpace,
      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
    )
    context?.translateBy(x: 0, y: outputSettings.size.height)
    context?.scaleBy(x: 1.0, y: -1.0)
    
    UIGraphicsPushContext(context!)
    image.draw(
      in: CGRect(
        x: 0,
        y: 0,
        width: outputSettings.size.width,
        height: outputSettings.size.height
      )
    )
    UIGraphicsPopContext()
    
    CVPixelBufferUnlockBaseAddress(unwrappedPixelBuffer, [])
    if input.isReadyForMoreMediaData {
      adaptor.append(
        unwrappedPixelBuffer,
        withPresentationTime: presentationTime
      )
    }
  }
  
  public func finish() {
    input.markAsFinished()
    assetWriter.finishWriting {
      self.saveMovieToAlbum(self.outputSettings.outputURL)
    }
  }
  
  private func saveMovieToAlbum(_ videoURL: URL) {
    PHPhotoLibrary.shared().performChanges({
      PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
    }) { _, error in
      if let error = error {
        self.continuation?.resume(throwing: error)
      } else {
        self.continuation?.resume(returning: true)
      }
    }
  }
}
