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
    var price: Int?
    var discoutedPrice: Int?
    var category: Category?
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        name = data.object(forKey: "nome") as? String
        productDescription = data.object(forKey: "descricao") as? String
        
        if let oldPrice = data.object(forKey: "precoDe") as? Double{
            price = Int(oldPrice)
        }else{
            price = data.object(forKey: "precoDe") as? Int
        }
        
        if let discouted = data.object(forKey: "precoPor") as? Double{
            discoutedPrice = Int(discouted)
        }else{
            discoutedPrice = data.object(forKey: "precoPor") as? Int
        }

        if let category = data.object(forKey: "categoria") as? NSDictionary{
            self.category = Category.init(data: category)
        }
    }
    
    func getProductDescriptionString() -> String{
        return "\(self.name ?? "") - \(self.productDescription ?? "")"
    }
    
    func getProductOldPriceString() -> String{
        if let price = self.price{
            return "De: \(String(price))"
        }
        
        return ""
    }
    
    func getProductNewPriceString() -> String{
        if let discoutedPrice = self.discoutedPrice{
            return "Por: \(String(discoutedPrice))"
        }
        
        return ""
    }
}
