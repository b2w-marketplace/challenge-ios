//
//  Product.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class Product: BaseContent {
    var name: String?
    var productDescription: String?
    var price: String?
    var discoutedPrice: String?
    var category: Category?
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        name = data.object(forKey: "nome") as? String
        productDescription = data.object(forKey: "descricao") as? String
        price = data.object(forKey: "precoDe") as? String
        discoutedPrice = data.object(forKey: "precoPor") as? String
        if let category = data.object(forKey: "categoria") as? NSDictionary{
            self.category = Category.init(data: category)
        }
    }
}
