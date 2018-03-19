//
//  ProductTableViewCell.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

import AlamofireImage
import Alamofire

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var thumbnail: UIImageView!
    @IBOutlet weak private var productName: UILabel!
    @IBOutlet weak private var oldPrice: UILabel!
    @IBOutlet weak private var price: UILabel!
    
    override var customObject: Any! {
        didSet {
            guard let product = customObject as? Product else {
                return
            }
            
            if let path = product.imageUrl {
                Alamofire.request(path).responseImage(completionHandler: { (imageResponse) in
                    if let image = imageResponse.result.value {
                        self.thumbnail.image = image
                    }
                })
            }
            
            productName.text = product.name
            oldPrice.text =  "De: R$" + "\(product.oldPrice.orNil)"
            price.text = "Por: R$" + "\(product.price.orNil)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension Optional { //gambeta power
    var orNil : String {
        if self == nil {
            return "nil"
        }
        if "\(Wrapped.self)" == "String" {
            return "\"\(self!)\""
        }
        return "\(self!)"
    }
}
