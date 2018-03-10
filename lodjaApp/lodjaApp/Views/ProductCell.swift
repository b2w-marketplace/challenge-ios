//
//  ProductCell.swift
//  lodjaApp
//
//  Created by Rodrigo Marangoni on 29/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var previousPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    func configureCell(_ product: Product) {
        self.productName.text = product.nome
        
        self.currentPrice.text = "Por: \(String(format:"%.2f",product.precoPor!))"
        self.previousPrice.setScratchedText("De: \(String(format:"%.2f",product.precoDe!))")
        
        if let url = URL(string:product.urlImage!) {
            self.productImage.af_setImage(withURL: url)
        }
        self.accessoryType = .disclosureIndicator
    }

}
