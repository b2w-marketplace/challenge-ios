//
//  AlodjinhaImageView.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class AlodjinhaImageView: UIImageView {
    let imageCache = NSCache<NSString, UIImage>()
    var imageUrlString: String?
    
    func downloadImage(withUrl urlString: String) {
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, _, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "placeholder")
                }
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    self.imageCache.setObject(image, forKey: NSString(string: urlString))
                    if self.imageUrlString == urlString {
                        self.image = image
                    }
                }
            }
        }.resume()
    }
}
