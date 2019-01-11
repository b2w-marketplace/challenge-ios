//
//  BannerCollectionViewCell.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 11/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()

        configure(with: nil)
    }

    override func awakeFromNib() {

    }

    private func configure(with banner: BannerList?) {

    }
}
