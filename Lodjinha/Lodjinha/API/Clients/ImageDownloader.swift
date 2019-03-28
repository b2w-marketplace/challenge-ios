//
//  ImageDownloader.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

protocol ImageDownloader {
    func downloadImage(from url: String, completion: @escaping (UIImage?,Error?) -> Void)
}

class LodjinhaImageDownloader: ImageDownloader {
    
    func downloadImage(from url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            let error = NSError(domain: "Lodjinha.ImageDownloader", code: 200, userInfo: [NSLocalizedDescriptionKey: "could not transform urlString:\(url) into URL type"])
            completion(nil, error)
            return
        }
        
        let stringObject = NSString(string: url)

        // check cache for image first
        if let cacheImage = imageCache.object(forKey: stringObject) as? UIImage {
            completion(cacheImage, nil)
            return
        }
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let imageData = data else {
                completion(nil, error)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                let error = NSError(domain: "Lodjinha.ImageDownloader", code: 210, userInfo: [NSLocalizedDescriptionKey: "could generate image from imageData"])
                completion(nil, error)
                return
            }
            
            completion(image, nil)
            imageCache.setObject(image, forKey: stringObject)
            
            }.resume()
    }
}
