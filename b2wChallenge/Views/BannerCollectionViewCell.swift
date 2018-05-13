//
//  BannerCollectionViewCell.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 10/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    var banners: DataBanners? {
        didSet {
            
            if let data = banners {
                
                if let urlImage = data.urlImagem {
                    self.bannerImageView.image = nil
                    
                    if let imageFromCache = Utils.imageCache.object(forKey: urlImage as AnyObject) as? UIImage {
                        self.bannerImageView.image = imageFromCache
                    } else {
                        bannerImageView.image = #imageLiteral(resourceName: "empty")
                    }
                }
            }
        }
    }
}
