//
//  CategoriesCollectionViewCell.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

struct CategoriesCellDTO {
    let image: String
    let description: String
}

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoriesImage: AlodjinhaImageView! {
        didSet {
            categoriesImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var categoriesDescriptionLabel: UILabel! {
        didSet {
            categoriesDescriptionLabel.numberOfLines = 0
            categoriesDescriptionLabel.lineBreakMode = .byWordWrapping
            categoriesDescriptionLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .semibold)
        }
    }
    
    func fill(dto: CategoriesCellDTO) {
        categoriesImage.downloadImage(withUrl: dto.image)
        categoriesDescriptionLabel.text = dto.description
    }
}
