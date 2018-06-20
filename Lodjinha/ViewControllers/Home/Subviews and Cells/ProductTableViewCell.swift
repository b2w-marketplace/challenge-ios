//
//  ProductTableViewCell.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageProduct: AlamofireImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductOriginalPrice: UILabel!
    @IBOutlet weak var labelProductCurrentPrice: UILabel!
    
    func setupWithProduct(_ product: ProductModel) {
        
        imageProduct.loadImageFor(url: product.imgUrl, placeholderImg: nil)
        labelProductName.text = product.name
        
        if product.discountPrice != nil {
            labelProductOriginalPrice.attributedText = product.formattedAttributedOriginalPrice()
            labelProductCurrentPrice.text = product.formattedDiscountPrice()
        } else {
            labelProductOriginalPrice.text = ""
            labelProductCurrentPrice.text = product.formattedOriginalPrice()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
