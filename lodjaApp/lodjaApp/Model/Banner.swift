//
//  Banner.swift
//  lodjaApp
//
//  Created by Rodrigo Marangoni on 30/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

class Banner: Mappable {
    var bannerId: Int?
    var urlImage: String?
    var linkUrl: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        bannerId <- map["id"]
        urlImage <- map["urlImagem"]
        linkUrl <- map["linkUrl"]
    }
    
}

class BannerData: Mappable{
    var data:[Banner]?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}
