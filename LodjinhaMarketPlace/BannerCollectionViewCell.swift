//
//  BannerCollectionViewCell.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerContainerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setBackgroundColor(_ color: UIColor) {
        bannerContainerView.backgroundColor = color
    }
}
