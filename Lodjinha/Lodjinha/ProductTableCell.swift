//
//  ProductTableCell.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

class ProductTableCell: UITableViewCell {
    @IBOutlet weak var photoIv: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceBeforeLbl: UILabel!
    @IBOutlet weak var priceNowLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
