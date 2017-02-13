//
//  Product.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import JSONJoy

class Product: JSONJoy
{
    let category: Category
    let id: Int
    let name: String
    let descritpion: String
    let oldPrice: Double
    let promotionalPrice: Double
    let urlImage: String
    
    init()
    {
        category = Category()
        id = 0
        name = ""
        descritpion = ""
        oldPrice = 0
        promotionalPrice = 0
        urlImage = ""
    }
    
    required init(_ decoder: JSONDecoder) throws
    {
        category = try Category(decoder["categoria"])
        id = try decoder["id"].get()
        name = try decoder["nome"].get()
        descritpion = try decoder["descricao"].get()
        oldPrice = try decoder["precoDe"].get()
        promotionalPrice = try decoder["precoPor"].get()
        urlImage = try decoder["urlImagem"].get()
    }
}
