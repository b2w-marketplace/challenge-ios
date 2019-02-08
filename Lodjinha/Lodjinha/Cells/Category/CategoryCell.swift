//
//  CategoryCell.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 27/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    public func setupCell(_ category: Categoria) {
        nameLabel.text = category.descricao
        iconImageView.kf.indicatorType = .activity
        iconImageView.kf.setImage(with: URL(string: category.urlImagem),
                                  placeholder: UIImage(named: "question"))
    }

}
