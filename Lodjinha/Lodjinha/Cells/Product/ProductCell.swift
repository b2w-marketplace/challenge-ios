//
//  BestSellerCell.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 27/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }
    
}
