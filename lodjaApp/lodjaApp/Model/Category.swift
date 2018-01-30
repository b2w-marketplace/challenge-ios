//
//  Category.swift
//  lodjaApp
//
//  Created by Rodrigo Marangoni on 30/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import Foundation
import ObjectMapper

class Category: Mappable {
    var descricao: String?
    var catId: Int?
    var urlImage: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        descricao <- map["descricao"]
        catId <- map["id"]
        urlImage <- map["urlImagem"]
    }
    
}

class CategoryData: Mappable{
    var data:[Category]?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}
