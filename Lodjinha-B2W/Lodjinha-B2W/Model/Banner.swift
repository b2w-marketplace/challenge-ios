//
//  Banner.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Banner: Mappable{
    
    var id:Int?
    var linkUrl:String?
    var urlImagem:String?
    var image:UIImage?
    
    //funçoes para modificar valores dentro da modal
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        linkUrl     <- map["linkUrl"]
        urlImagem   <- map["urlImagem"]
    }
}

class InfoBanner: Mappable{
    
    var data:[Banner]?
    
    //funçoes para modificar valores dentro da modal
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        data          <- map["data"]
    }
}

