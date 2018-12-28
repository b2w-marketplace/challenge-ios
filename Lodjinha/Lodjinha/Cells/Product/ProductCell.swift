//
//  BestSellerCell.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 27/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyAttributes

class ProductCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
        tintColor = .mainColor
    }
    
    public func setupCell(_ product: Produto) {
        nameLabel.text = product.nome
        iconImageView.kf.indicatorType = .activity
        iconImageView.kf.setImage(with: URL(string: product.urlImagem),
                                  placeholder: UIImage(named: "question"))
        let text = "De: \(moneyFormatter(product.precoDe))"
        oldPriceLabel.attributedText = text.withStrikethroughColor(.lightGray).withStrikethroughStyle(.single)
        newPriceLabel.text = "Por \(moneyFormatter(product.precoPor))"
    }

}
