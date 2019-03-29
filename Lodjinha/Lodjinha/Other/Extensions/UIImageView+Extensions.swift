//
//  UIImageView+Extensions.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(fromUrl url: String, withIndicator indicator: UIActivityIndicatorView?, defaultImage: UIImage? = nil) {
        indicator?.startAnimating()
        let imageDownloader = LodjinhaImageDownloader()
        imageDownloader.downloadImage(from: url) { (image, error) in
            DispatchQueue.main.async { [unowned self] in
                if let downloadedImage = image {
                    self.image = downloadedImage
                } else {
                    self.image = defaultImage
                }
                
                indicator?.stopAnimating()
            }
        }
        
    }
    
}
