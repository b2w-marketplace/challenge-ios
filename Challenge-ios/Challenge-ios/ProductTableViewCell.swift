//
//  ProductTableViewCell.swift
//  Challenge-ios
//
//  Created by Roberto L V Junior on 17/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var acLoadingLabels: UIActivityIndicatorView!
    @IBOutlet weak var acLoadingImg: UIActivityIndicatorView!
	@IBOutlet weak var imgProduct: UIImageView!
	@IBOutlet weak var lbDescription: UILabel!
	@IBOutlet weak var lbPriceFrom: UILabel!
	@IBOutlet weak var lbPrice: UILabel!

    func load(product: Product) {
		if let description = product.description {
			self.lbDescription.text = description
		}

		if let priceFrom = product.priceFrom {
			self.lbPriceFrom.text = "De: " + String(priceFrom)
            let line = UIView(frame: CGRect(x: 0, y: self.lbPriceFrom.frame.height/2, width: self.lbPriceFrom.frame.width, height: 1))
            line.backgroundColor = UIColor.lightGray
            self.lbPriceFrom.addSubview(line)
		}

		if let price = product.price {
			self.lbPrice.text = "Por: " + String(price)
		}

		if let product = product.description {
			self.lbDescription.text = product
		}

        self.acLoadingLabels.stopAnimating()
        
		if let image = product.image {
			DispatchQueue.main.async(execute: {
				Product.downloadImage(url: image) { (image) in
					self.imgProduct?.image = image
                    self.acLoadingImg.stopAnimating()
				}
			})
		}
	}
}
