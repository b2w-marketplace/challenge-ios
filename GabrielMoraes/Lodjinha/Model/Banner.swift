//
//  Banner.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit
import ObjectMapper

class Banner: NSObject, Mappable {
    
    var id: Int!
    var linkUrl: URL!
    var imageUrl: URL!
    
    required init?(map: Map) {
        
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        linkUrl <- (map["linkUrl"], URLTransform())
        imageUrl <- (map["urlImagem"], URLTransform())
    }
}
