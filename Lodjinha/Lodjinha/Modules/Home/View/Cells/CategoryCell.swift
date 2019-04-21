//
//  CategoryCell.swift
//  Lodjinha
//
//  Created by Marcos on 21/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import AlamofireImage

class CategoryCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var labelDescription: UILabel!
    
    @IBOutlet private weak var imageViewCategory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAccessibilityIdentifiers()
        applyStyle()
    }
    
    private func setupAccessibilityIdentifiers() {
        labelDescription.accessibilityIdentifier = "labelDescription"
        
        imageViewCategory.accessibilityIdentifier = "imageViewCategory"
    }
    
    private func applyStyle() {
        Style.text(font: UIFont.systemFont(ofSize: 11),
                   color: Palette.Gray.main.color,
                   alignment: .center)
            .apply(on: labelDescription)
    }
    
    func setup(category: Category) {
        labelDescription.text = category.descricao
        if let url = URL(string: category.urlImagem) {
            imageViewCategory.af_setImage(withURL: url,
                                          placeholderImage: UIImage(identifier: .placeholder))
        }
    }

}
