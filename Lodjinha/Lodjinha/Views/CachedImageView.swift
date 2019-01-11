//
//  CachedImageView.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit
import Alamofire

let imageCache = NSCache<NSString, UIImage>()

class CachedImageView: UIImageView {

    var imageName: String?

    func loadImageFromURL(imageUrl: String, defaultImage: UIImage? = nil, circleImage: Bool = false ) {

        if circleImage {
            self.layer.cornerRadius = self.frame.size.width/2
            self.clipsToBounds = true
        }

        if let cachedImage = imageCache.object(forKey: imageUrl as NSString) {
            crossDisolveImage(image: cachedImage, duration: 0.1)
            return
        } else if let defaultImage = defaultImage {
            crossDisolveImage(image: defaultImage, duration: 0.1)
        }

        self.imageName = imageUrl

        guard let url = URL(string: imageUrl) else { return }

        Alamofire.request(url).responseData { (response) in
            guard let data = response.data, let imageData = UIImage(data: data), response.error == nil else {
                print(response.result)
                return
            }
            imageCache.setObject(imageData, forKey: imageUrl as NSString)

            if response.response?.url?.absoluteString == self.imageName {
                self.crossDisolveImage(image: imageData)
            }
        }
    }

    private func crossDisolveImage(image: UIImage, duration: Double = 0.3) {
        DispatchQueue.main.async {
            UIView.transition(with: self,
                              duration: duration,
                              options: .transitionCrossDissolve,
                              animations: { self.image = image },
                              completion: nil)
        }
    }

}

