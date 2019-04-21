//
//  BannerView.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit
import Kingfisher

struct BannerViewDTO {
    var image: URL?
}

class BannerView: UIView {

    @IBOutlet weak var bannerImage: UIImageView!

    func fill(dto: BannerViewDTO) {
        if let url = dto.image {
            bannerImage.kf.setImage(with: url)
        }
    }
    
}
