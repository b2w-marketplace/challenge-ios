//
//  PrincingTableViewCell.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

class PrincingTableViewCell: UITableViewCell {

    @IBOutlet weak private var oldPrice: UILabel!
    
    @IBOutlet weak private var price: UILabel!
    
    override var customObject: Any! {
        didSet {
            guard let product = customObject as? Product else {
                return
            }
            
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale.current
            
            if let formattedOldPrice = numberFormatter.string(from: NSNumber(value: product.oldPrice!)) {
                oldPrice.text = "Por: R$" + formattedOldPrice + ",00"
            }
            
            if let formattedPrice = numberFormatter.string(from: NSNumber(value: product.price!)) {
                price.text = "Por: R$" + formattedPrice + ",00"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
