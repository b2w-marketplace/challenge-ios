//
//  Product.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit
import ObjectMapper

class Product: NSObject, Mappable {
    
    var id: Int!
    var name: String!
    var desc: String!
    var category: Category!
    var priceOld: Float!
    var priceNew: Float!
    var imageUrl: URL!
    
    required init?(map: Map) {
        
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["nome"]
        desc <- map["descricao"]
        category <- map["categoria"]
        priceOld <- map["precoDe"]
        priceNew <- map["precoPor"]
        imageUrl <- (map["urlImagem"], URLTransform())
    }
    
}
