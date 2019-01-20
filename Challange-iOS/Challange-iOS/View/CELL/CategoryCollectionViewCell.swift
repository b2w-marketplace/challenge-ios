//
//  CategoryCollectionViewCell.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 20/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func configureCell(category: Category) {
        if let urlImage = category.urlImagem {
            let url = URL(string: urlImage)
            let resource = ImageResource(downloadURL: url!)
            productImage.kf.setImage(with: resource)
        }
        if let desciption = category.descricao {
            descriptionLabel.text = desciption
        }
    }
    
}
