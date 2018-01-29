//
//  TopSellerCellTableViewCell.swift
//  teste
//
//  Created by Rodrigo Marangoni on 29/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit

class TopSellerCellTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var previousPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    func configureCell(_ name:String, de:Float, por:Float, imageUrl:String) {
        self.productName.text = name
        self.currentPrice.text = "Por: \(String(format:"%.2f",por))"
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "De: \(String(format:"%.2f",de))")
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        previousPrice.attributedText = attributeString;
        
        if let url = URL(string:imageUrl) {
            self.productImage.af_setImage(withURL: url)
        }
        
    }

}
