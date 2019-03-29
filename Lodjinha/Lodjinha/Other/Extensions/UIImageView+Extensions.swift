//
//  UIImageView+Extensions.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

@objc protocol UrlSettableImageView {
    @objc func setImage(fromUrl url: String, withIndicator indicator: UIActivityIndicatorView?, defaultImage: UIImage?)
}

extension UIImageView: UrlSettableImageView {
    
    func setImage(fromUrl url: String, withIndicator indicator: UIActivityIndicatorView?, defaultImage: UIImage? = nil) {
        indicator?.startAnimating()
        LodjinhaImageDownloader().downloadImage(from: url) { (image, error) in
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
