//
//  Product.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

class Product {
    
    public var id: Int
    public var name: String
    public var urlImagem: String
    public var description: String
    public var oldPrice: Double
    public var price: Double
    public var category: Category
    
    
    init(id: Int,
         name: String,
         urlImagem: String,
         description: String,
         oldPrice: Double,
         price: Double,
         category: Category) {
        
        self.id = id
        self.name = name
        self.urlImagem = urlImagem
        self.description = description
        self.oldPrice = oldPrice
        self.price = price
        self.category = category
    }
    
}
