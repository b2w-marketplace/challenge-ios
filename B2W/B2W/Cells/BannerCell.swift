//
//  BannerCell.swift
//  B2W
//
//  Created by Nicholas Matos on 2/6/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit
import SDWebImage

class BannerCell: UICollectionViewCell {
    @IBOutlet weak var bannerImage: UIImageView!
    
    func bind(banner: Banner){
        if let stringUrl = banner.urlImagem{
            if let url = URL(string: stringUrl){
                bannerImage.sd_setImage(with: url, completed: nil)
            }
        }
    }
}
