//
//  Categoria.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Categoria: Mappable{
    
    var id:Int?
    var descricao:String?
    var urlImagem:String?
    
    //funçoes para modificar valores dentro da modal
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        descricao   <- map["descricao"]
        urlImagem   <- map["urlImagem"]
    }
}

class InfoCategoria: Mappable{
    
    var data:[Categoria]?
    
    //funçoes para modificar valores dentro da modal
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        data    <- map["data"]
    }
}
