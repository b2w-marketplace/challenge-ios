//
//  ProductCell.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPriceOld: UILabel!
    @IBOutlet weak var lblPriceNew: UILabel!
    
    var product: Product! {
        didSet {
            self.imgProduct.kf.setImage(with: product.imageUrl)
            self.lblName.text = product.name
            self.lblPriceOld.text = Strings.productCellPriceOld + product.priceOld.asLocaleCurrency
            self.lblPriceNew.text = Strings.productCellPriceNew + product.priceNew.asLocaleCurrency
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
