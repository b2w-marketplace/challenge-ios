//
//  Product.swift
//  teste
//
//  Created by Rodrigo Marangoni on 30/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: Mappable {
    var category: Category?
    var descricao: String?
    var prodId: Int?
    var urlImage: String?
    var nome: String?
    var precoDe: Float?
    var precoPor: Float?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        category <- map["categoria"]
        descricao <- map["descricao"]
        prodId <- map["id"]
        urlImage <- map["urlImagem"]
        nome <- map["nome"]
        precoDe <- map["precoDe"]
        precoPor <- map["precoPor"]
    }
}

class ProductData: Mappable{
    var data:[Product]?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}
