//
//  ProductTableViewCell.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let identifier: String = "ProductTableViewCell"
    
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
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "pt-BR")
        productImage.setImage(fromUrl: product.imageUrl, withIndicator: nil, defaultImage: UIImage(named: "downloadImageDefault"))
        productName.text = product.name
        
        //Attributed Text
        let text = "De \(numberFormatter.string(from: NSNumber(value: product.priceBefore))!)"
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.strikethroughStyle : 1])
        productPriceBefore.attributedText = attributedString
        
        productPriceNow.text = "Por \(numberFormatter.string(from: NSNumber(value: product.priceNow))!)"
        separatorView.isHidden = isLastIndex
    }
    
}
