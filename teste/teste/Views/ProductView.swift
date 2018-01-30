//
//  ProductView.swift
//  lodjaApp
//
//  Created by Rodrigo Marangoni on 30/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit

class ProductView: UIView {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var priceDe: UILabel!
    @IBOutlet weak var pricePor: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    
    func configure(_ product: Product) {
        self.productTitle.text = product.nome
        self.setDescription(product.descricao)
        self.pricePor.text = "Por: \(String(format:"%.2f",product.precoPor!))"
        self.priceDe.setScratchedText("De: \(String(format:"%.2f",product.precoDe!))")
        
        if let url = URL(string:product.urlImage!) {
            self.productImage.af_setImage(withURL: url)
        }
        
    }
    
    func setDescription(_ description: String?) {
        do {
            let attrStr = try NSAttributedString(
                data: (description?.data(using: String.Encoding.unicode, allowLossyConversion: true))!,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            self.productDescription.attributedText = attrStr;
        } catch let error {
            print (error)
        }
    }
    
}

