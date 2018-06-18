//
//  CategoryCollectionViewCell.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 14/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Lets and Vars
    var category: Category? {
        didSet {
            categoryImage.kf.setImage(with: URL(string: "\((category?.urlImagem)!)"))
            categoryName.text = (category?.descricao)!
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
