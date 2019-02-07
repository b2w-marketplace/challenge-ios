//
//  ProductCell.swift
//  B2W
//
//  Created by Nicholas Matos on 2/6/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDiscoutedPrice: UILabel!
    
    func bind(product: Product){
        if let stringUrl = product.urlImagem{
            if let url = URL(string: stringUrl){
                productImage.sd_setImage(with: url, completed: nil)
            }
        }
        
        productDescription.text = product.getProductDescriptionString()
        productPrice.text = product.price
        productDiscoutedPrice.text = product.discoutedPrice
    }
}
