//
//  ImageDownloader.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

protocol ImageDownloader {
    func downloadImage(from url: String, completion: @escaping (UIImage?,Error?) -> Void)
}

class BannerImageDownloader: ImageDownloader {
    func downloadImage(from url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
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
            
            completion(UIImage(data: imageData), nil)
            
            }.resume()
    }
}
