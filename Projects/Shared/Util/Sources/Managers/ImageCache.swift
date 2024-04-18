//
//  ImageCache.swift
//  SharedUtil
//
//  Created by 황제하 on 4/18/24.
//

import UIKit

public final class ImageCache {
  public static let shared = ImageCache()
  
  private init() { }
  
  public func saveImageToDiskCache(
    _ image: UIImage,
    forKey key: String
  ) {
    if let data = image.pngData() {
      let url = diskCacheURL(forKey: key)
      try? data.write(to: url)
    }
  }
  
  public func loadImageFromDiskCache(
    forKey key: String
  ) -> UIImage? {
    let url = diskCacheURL(forKey: key)
    guard let data = try? Data(contentsOf: url) else {
      return nil
    }
    return UIImage(data: data)
  }
  
  private func diskCacheURL(forKey key: String) -> URL {
    let cacheDirectory = FileManager.default.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    ).first!
    let fileURL = cacheDirectory.appendingPathComponent(key)
    return fileURL
  }
}
