//
//  CategoryCollectionViewCell.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCategoryImage( image: UIImage?) {
        categoryImage.image = image ?? UIImage.init(named: "NotFound")
    }
    
    func setCategoryDescription(_ text: String?) {
        categoryTitle.text = text ?? ""
    }
}
