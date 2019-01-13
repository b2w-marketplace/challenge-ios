//
//  PriceTableViewCell.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 10/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

    @IBOutlet weak var priceOff: UILabel!
    @IBOutlet weak var salePrice: UILabel!
    
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
    }
    
    final fileprivate func clean() {
        priceOff.text = nil
        priceOff.attributedText = nil
        salePrice.text = nil
    }
}

//MARK: Public methods
extension PriceTableViewCell {
    public func contructWith(priceOff: Float, salePrice: Float) {
        self.priceOff.attributedText = getPriceOffFormatted(value: priceOff)
        self.salePrice.text = "R$ \(salePrice)"
    }
}

//MARK: Private methods
extension PriceTableViewCell {
    final fileprivate func getPriceOffFormatted(value: Float) -> NSMutableAttributedString {
        let offPrice = String(format: "De R$ %.2f", value)
        let attributtedString = NSMutableAttributedString(string: offPrice,
                                                          attributes: [.font: UIFont.systemFont(ofSize: 12.0),
                                                                       .foregroundColor: UIColor.lightGray,
                                                                       .strikethroughColor: UIColor.lightGray,
                                                                       .strikethroughStyle: NSUnderlineStyle.single.rawValue])
        
        return attributtedString
    }
}
