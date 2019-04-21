//
//  CategoryViewCell.swift
//  Challenge-Alodjinha
//
//  Created by Luis Henrique Tavares Ferreira on 17/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit
import Kingfisher

struct CategoryCellDTO {
    var image: URL?
    var description: String
}

class CategoryViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func fill(dto: CategoryCellDTO) {
        descriptionLabel.text = dto.description
        
        if let url = dto.image {
            categoryImage.contentMode = .scaleAspectFill
            categoryImage.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "empty"))
        }
    }
}
