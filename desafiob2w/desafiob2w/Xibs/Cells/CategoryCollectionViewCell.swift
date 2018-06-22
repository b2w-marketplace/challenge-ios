//
//  CategoryCollectionViewCell.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCategoryImageView: UIImageView!
    @IBOutlet weak var descriptionCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        imageCategoryImageView.kf.indicatorType = .activity
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        imageCategoryImageView.kf.cancelDownloadTask()
        super.prepareForReuse()
    }
}

extension CategoryCollectionViewCell: ViewCellHandler {
    func setData(_ data: CategoryViewModel) {
        imageCategoryImageView.kf.setImage(with: data.urlImage)
        descriptionCategoryLabel.text = data.description
    }
}
