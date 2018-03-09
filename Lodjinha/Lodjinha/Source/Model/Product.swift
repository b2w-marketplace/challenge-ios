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
    var oldPrice : Int
    var newPrice : Int
    var imageUrl : String
    var offset : Int
    var total : Int
    
    enum CodingKeys: String, CodingKey {
        case category = "categoria"
        case description = "descricao"
        case id
        case name = "nome"
        case oldPrice = "precoDe"
        case newPrice = "precoPor"
        case imageUrl = "urlImagem"
        case offset
        case total
    }
}
