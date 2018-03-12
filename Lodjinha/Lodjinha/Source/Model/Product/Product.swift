//
//  Product.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

struct Product : Codable {
    var category : Category
    var description : String
    var id : Int
    var name : String
    var oldPrice : Double
    var newPrice : Double
    var imageUrl : String
    
    enum CodingKeys: String, CodingKey {
        case category = "categoria"
        case description = "descricao"
        case id
        case name = "nome"
        case oldPrice = "precoDe"
        case newPrice = "precoPor"
        case imageUrl = "urlImagem"
    }
}
