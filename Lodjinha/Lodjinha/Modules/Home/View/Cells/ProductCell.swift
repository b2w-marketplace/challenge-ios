//
//  ProductCell.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var imageViewProduct: UIImageView!
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPriceFrom: UILabel!
    @IBOutlet weak var labelPriceTo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
