//
//  CategoryCollectionViewCell.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 10/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clean()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clean()
    }
 
    final fileprivate func setup() {
        isAccessibilityElement = true
        
        categoryImage.contentMode = .scaleAspectFit
        categoryImage.clipsToBounds = true
    }
    
    final fileprivate func clean() {
        categoryImage.image = nil
        categoryName.text = nil
    }
}

//MARK: Public methods
extension CategoryCollectionViewCell {
    public func constructWith(name: String?, imageUrl: String?) {
        categoryName.text = name
        categoryImage.setImageFrom(url: imageUrl)
    }
}
