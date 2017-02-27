//
//  BannerCell.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var imgBanner: UIImageView!
    
    var banner: Banner! {
        didSet {
            self.imgBanner.kf.setImage(with: banner.imageUrl)
        }
    }
}
