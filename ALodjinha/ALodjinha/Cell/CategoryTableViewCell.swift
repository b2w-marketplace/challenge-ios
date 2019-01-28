//
//  CategoryTableViewCell.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryTableViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(model: CategoryModel) {
        categoryNameLabel.text = model.description
        let url = URL(string: model.urlImage)
        categoryImage.kf.indicatorType = .activity
        categoryImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.jpg"))
    }

}
