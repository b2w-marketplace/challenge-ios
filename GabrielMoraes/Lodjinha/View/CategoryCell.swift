//
//  CategoryCell.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    
    var category: Category! {
        didSet {
            self.imgCategory.kf.setImage(with: category.imageUrl)
            self.lblDesc.text = category.desc
        }
    }
    
}
