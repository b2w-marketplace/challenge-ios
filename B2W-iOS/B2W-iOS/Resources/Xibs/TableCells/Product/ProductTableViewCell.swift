//
//  ProductTableViewCell.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 10/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clean()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clean()
    }
    
    final fileprivate func setup() {
        isAccessibilityElement = true
        
        productImage.contentMode = .scaleAspectFit
        productImage.clipsToBounds = true
    }
    
    final fileprivate func clean() {
        productImage.image = nil
        productName.text = nil
    }
}

//MARK: Public methods
extension ProductTableViewCell {
    public func contructWith(productImageUrl: String?, productName: String?) {
        self.productName.text = productName
        self.productImage.setImageFrom(url: productImageUrl)
    }
}
