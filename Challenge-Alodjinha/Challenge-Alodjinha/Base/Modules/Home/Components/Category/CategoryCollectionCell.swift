//
//  CategoryCollectionCell.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit
import Kingfisher

struct CategoryCellDTO {
    var image: URL?
    var description: String
}

class CategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    func fill(dto: CategoryCellDTO) {
        descriptionLabel.text = dto.description
        
        if let url = dto.image {
            categoryImage.kf.setImage(with: url)
        }
    }
}
