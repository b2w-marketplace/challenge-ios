//
//  ProductTableViewCell.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

struct ProductCellDTO {
    let name: String
    let image: String
    let priceDe: Double
    let pricePor: Double
}

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: AlodjinhaImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceDeLabel: UILabel!
    @IBOutlet weak var pricePorLabel: UILabel!
    
    func fill(dto: ProductCellDTO) {
        productImage.downloadImage(withUrl: dto.image)
        nameLabel.text = dto.name
        priceDeLabel.text = String(dto.priceDe)
        pricePorLabel.text = String(dto.pricePor)
    }
}
