//
//  ProductCell.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class ProductCell: UITableViewCell, NibReusable {

    @IBOutlet weak var imageViewProduct: UIImageView!
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPriceFrom: UILabel!
    @IBOutlet weak var labelPriceTo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAccessibilityIdentifiers()
        applyStyle()
    }
    
    private func setupAccessibilityIdentifiers() {
        imageViewProduct.accessibilityIdentifier = "imageViewProduct"
        
        labelDescription.accessibilityIdentifier = "labelDescription"
        labelPriceFrom.accessibilityIdentifier = "labelPriceFrom"
        labelPriceTo.accessibilityIdentifier = "labelPriceTo"
    }
    
    private func applyStyle() {
        accessoryType = .disclosureIndicator
        tintColor = UIColor.blue
        
        Style.text(font: UIFont.boldSystemFont(ofSize: 15),
                   color: Palette.Gray.main.color,
                   alignment: .left)
            .apply(on: labelDescription)
        
        Style.text(font: UIFont.systemFont(ofSize: 12),
                   color: Palette.Gray.light.color,
                   alignment: .left)
            .apply(on: labelPriceFrom)
        
        Style.text(font: UIFont.boldSystemFont(ofSize: 18),
                   color: Palette.Orange.main.color,
                   alignment: .right)
            .apply(on: labelPriceTo)
    }
    
    func setup(product: Product) {
        labelDescription.text = product.descricao
        labelPriceFrom.attributedText = "\(String(identifier: .from)): \(product.precoDe.currency(by: NumberFormatter.currencyPtBr))".strikethrough
        labelPriceTo.text = "\(String(identifier: .to)): \(product.precoPor.currency(by: NumberFormatter.currencyPtBr))"
        if let url = URL(string: product.urlImagem) {
            imageViewProduct.af_setImage(withURL: url)
        }
    }
    
}
