//
//  ProductTableViewCell.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell
{
    // MARK: - Var
    var product: Product?
    {
        didSet
        {
            if let product = product
            {
                let text = product.name + "<br/><br/>" + product.strDescription
                setDescription(text: text)
                setOldPriceLabel(price: product.priceOld)
                setNewPriceLabel(price: product.priceNew)
                setImage(imgURL: product.image.urlImage)
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productOldPriceLabel: UILabel!
    @IBOutlet weak var productNewPriceLabel: UILabel!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        
    }

    
    private func setDescription(text: String)
    {
        productDescriptionLabel.attributedText = text.html2AttributedString
    }
    
    private func setOldPriceLabel(price: Double)
    {
        productOldPriceLabel.attributedText = price.oldPrice
    }
    
    private func setNewPriceLabel(price: Double)
    {
        productNewPriceLabel.text = price.newPrice
    }
    
    private func setImage(imgURL: String)
    {
        productImage.download(image: imgURL)
    }
}
