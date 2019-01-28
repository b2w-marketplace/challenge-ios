//
//  ProductTableViewCell.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceFromLabel: UILabel!
    @IBOutlet weak var productPriceToLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(model: ProductModel) {
        productNameLabel.text = model.name
        let attributeString =  NSMutableAttributedString(string: String(format: "De: R$ %.2f", model.priceFrom))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        productPriceFromLabel.attributedText = attributeString
        productPriceToLabel.text = String(format: "Por: R$ %.2f", model.priceTo)
        let url = URL(string: model.urlImage)
        productImageView.kf.indicatorType = .activity
        productImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.jpg"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        return
    }

}
