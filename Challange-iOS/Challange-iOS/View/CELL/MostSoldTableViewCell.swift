//
//  MostSoldTableViewCell.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 20/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import Kingfisher

class MostSoldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!

    func configureCell(mostSold: Products) {
        
        if let urlImage = mostSold.urlImagem {
            let url = URL(string: urlImage)
            let resource = ImageResource(downloadURL: url!)
            productImage.kf.setImage(with: resource)
        }
        
        productNameLabel.text = mostSold.nome ?? ""
        newPriceLabel.text = mostSold.precoPor?.formatCurrency() ?? ""
        oldPriceLabel.attributedText = mostSold.precoDe?.setupAttribuites()
        
    }
    

}
