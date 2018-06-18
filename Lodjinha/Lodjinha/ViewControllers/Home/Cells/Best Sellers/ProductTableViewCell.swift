//
//  ProductTableViewCell.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 14/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    
    //MARK: - Lets and Vars
    var delegate: CellDelegate!
    var product: Product? {
        didSet {
            productImage.kf.setImage(with: URL(string: (product?.urlImagem)!)!)
            productNewValue.text = "Por: \((product?.precoPor.asLocaleCurrency)!)"
            productPreviousValue.text = "De: \((product?.precoDe.asLocaleCurrency)!)"
            productDescription.text = (product?.nome)!//.html2String
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNewValue: UILabel!
    @IBOutlet weak var productPreviousValue: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
