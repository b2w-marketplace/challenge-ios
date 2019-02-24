//
//  ImageWorker.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ImageWorker {
  static let shared = ImageWorker()

  private let cache = NSCache<NSString, UIImage>()

  func image(from urlString: String, completion: @escaping ((String, UIImage)?) -> Void) {
    // memmory cache
    if let cached = cache.object(forKey: urlString as NSString) {
      return completion((urlString, cached))
    }

    // disk cache
    if let disked = getFile(with: urlString), let image = UIImage(data: disked) {
      cache.setObject(image, forKey: urlString as NSString)
      return completion((urlString, image))
    }

    // download image
    ImageNetworking.getImage(urlString: urlString) { [weak self] callback in
      do {
        let data = try callback()
        guard let image = UIImage(data: data) else { return completion(nil) }

        // insert in disk cache
        self?.createFile(urlString, contents: data)
        // insert in memmory cache
        self?.cache.setObject(image, forKey: urlString as NSString)
        completion((urlString, image))
      } catch {
        completion(nil)
      }
    }
  }

  func getFile(with urlString: String) -> Data? {
    let manager = FileManager.default
    let filename = urlString.components(separatedBy: "/").last ?? urlString
    let path = NSTemporaryDirectory().appending(filename)
    return manager.contents(atPath: path)
  }

  func createFile(_ urlString: String, contents: Data) {
    let manager = FileManager.default
    let filename = urlString.components(separatedBy: "/").last ?? urlString
    let path = NSTemporaryDirectory().appending(filename)
    manager.createFile(atPath: path, contents: contents, attributes: nil)
  }
}
