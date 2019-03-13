//
//  ProductModel.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

struct ProductModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: URL
    let oldPrice: Float
    let newPrice: Float
    
    let category: CategoryModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
        case description = "descricao"
        case imageUrl = "urlImagem"
        case oldPrice = "precoDe"
        case newPrice = "precoPor"
        case category = "categoria"
    }
}
