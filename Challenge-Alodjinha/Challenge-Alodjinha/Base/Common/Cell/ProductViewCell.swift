//
//  ProductViewCell.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit
import Kingfisher

struct ProductCellDTO {
    var image: URL?
    var name: String
    var oldValue: Double
    var newValue: Double
}

class ProductViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oldValueLabel: UILabel!
    @IBOutlet weak var newValueLabel: UILabel!
    
    func fill(dto: ProductCellDTO) {
        nameLabel.text = dto.name
        oldValueLabel.text = String(dto.oldValue)
        newValueLabel.text = String(dto.newValue)
        
        if let url = dto.image {
            productImage.kf.setImage(with: url)
        }
    }
    
}
