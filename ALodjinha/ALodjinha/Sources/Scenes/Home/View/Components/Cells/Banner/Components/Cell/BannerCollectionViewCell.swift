//
//  BannerCollectionViewCell.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

struct BannerCellDTO {
    let image: String
}

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: AlodjinhaImageView! {
        didSet {
            bannerImage.contentMode = .scaleAspectFill
        }
    }
    
    func fill(dto: BannerCellDTO) {
        bannerImage.downloadImage(withUrl: dto.image)
    }
}
