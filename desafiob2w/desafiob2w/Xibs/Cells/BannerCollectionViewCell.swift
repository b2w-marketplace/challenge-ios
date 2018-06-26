//
//  BannerCollectionViewCell.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!

    override func awakeFromNib() {
        bannerImageView.kf.indicatorType = .activity
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        bannerImageView.kf.cancelDownloadTask()
        super.prepareForReuse()
    }
}

extension BannerCollectionViewCell: ViewCellHandler {
    func setData(_ data: BannerViewModel) {
        bannerImageView.kf.setImage(with: data.urlImagem)
    }
}
