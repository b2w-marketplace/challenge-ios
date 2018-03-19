
//  Product.swift
//  Lodjinha
//
//  Created by Daniel Novio on 18/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

struct Product: GenericObjectSerializable {
    
    var category: Category?
    var id: Int?
    var description: String?
    var name: String?
    var oldPrice: Double?
    var price: Double?
    var imageUrl: String?
    
    init?(fromJSON json: NSDictionary?) {
        guard let json = json else {
            return
        }
        
        self.category = Category(fromJSON: json["categoria"] as? NSDictionary)
        self.id = json["id"] as? Int
        self.description = json["descricao"] as? String
        self.name = json["nome"] as? String
        self.oldPrice = json["precoDe"] as? Double
        self.price = json["precoPor"] as? Double
        self.imageUrl = json["urlImagem"] as? String
    }
}
