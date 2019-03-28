//
//  UIImageView+Extensions.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(fromUrl url: String, withIndicator indicator: UIActivityIndicatorView?) {
        indicator?.startAnimating()
        let imageDownloader = LodjinhaImageDownloader()
        imageDownloader.downloadImage(from: url) { (image, error) in
            DispatchQueue.main.async { [unowned self] in
                self.image = image
                indicator?.stopAnimating()
            }
        }
        
    }
    
}
