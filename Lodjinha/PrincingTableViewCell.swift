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
            
            oldPrice.text =  "De: R$" + "\(product.oldPrice.orNil)"
            price.text = "Por: R$" + "\(product.price.orNil)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
