//
//  CategoryCell.swift
//  B2W
//
//  Created by Nicholas Matos on 2/6/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryDescription: UILabel!

    func bind(category: Category){
        if let stringUrl = category.urlImagem{
            if let url = URL(string: stringUrl){
                categoryImage.sd_setImage(with: url, completed: nil)
            }
        }
        
        categoryDescription.text = category.categoryDescription
    }
}
