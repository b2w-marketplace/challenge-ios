//
//  ProductTableViewCell.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPriceBefore: UILabel!
    @IBOutlet weak var productPriceNow: UILabel!
    
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withProduct product: Product, isLastIndex: Bool) {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.currencyDecimalSeparator = ","
        productImage.setImage(fromUrl: product.imageUrl, withIndicator: nil)
        productName.text = product.name
        productPriceBefore.text = "De \(numberFormatter.string(from: NSNumber(value: product.priceBefore))!)"
        productPriceNow.text = "Por \(numberFormatter.string(from: NSNumber(value: product.priceNow))!)"
        separatorView.isHidden = isLastIndex
    }
    
}
