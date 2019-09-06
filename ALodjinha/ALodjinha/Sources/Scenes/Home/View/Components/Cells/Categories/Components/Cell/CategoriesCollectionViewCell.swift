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

    @IBOutlet weak var categoriesImage: AlodjinhaImageView!
    @IBOutlet weak var categoriesDescriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func fill(dto: CategoriesCellDTO) {
        categoriesImage.downloadImage(withUrl: dto.image)
        categoriesDescriptionLabel.text = dto.description
        hideLoading()
    }
    
    private func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
