//
//  Category.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit
import ObjectMapper

class Category: NSObject, Mappable {
    
    var id: String!
    var desc: String!
    var imageUrl: URL!
    
    required init?(map: Map) {
        
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        desc <- map["descricao"]
        imageUrl <- (map["urlImagem"], URLTransform())
    }
}
