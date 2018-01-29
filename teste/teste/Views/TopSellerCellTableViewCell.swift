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
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "De: 9999,99")
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        previousPrice.attributedText = attributeString;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
