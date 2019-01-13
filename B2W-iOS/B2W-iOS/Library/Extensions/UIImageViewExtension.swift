//
//  UIImageView+SDWebImage.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func setImageFrom(url: String?,
                      placeholderImage: UIImage? = Asset.iconSemfoto.image,
                      completion: SDExternalCompletionBlock? = nil) {
        
        guard let safeUrlStr = url, let url: URL = URL(string: safeUrlStr) else {
            return
        }
        
        sd_setShowActivityIndicatorView(true)
        sd_setIndicatorStyle(.gray)
        
        if completion == nil {
            sd_setImage(with: url, placeholderImage: placeholderImage, options: [.highPriority, .retryFailed, .progressiveDownload]) { [weak self] (img, error, type, url) in
                self?.sd_setShowActivityIndicatorView(false)
            }
            
        } else {
            sd_setImage(with: url, placeholderImage: placeholderImage, options: [.avoidAutoSetImage, .highPriority, .retryFailed, .progressiveDownload]) { [weak self] (img, error, type, url) in
                completion?(img, error, type, url)
                self?.sd_setShowActivityIndicatorView(false)
            }
        }
    }
    
    func cancelLoadingImage() {
        sd_cancelCurrentImageLoad()
        sd_setShowActivityIndicatorView(false)
    }
}
