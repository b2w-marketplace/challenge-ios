//
//  Produto.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Produto: Mappable{
    
    var id:Int?
    var descricao:String?
    var urlImagem:String?
    var nome:String?
    var precoDe:Double?
    var precoPor:Double?
    var categoria: Categoria?
    
    
    //funçoes para modificar valores dentro da modal
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        descricao   <- map["descricao"]
        urlImagem   <- map["urlImagem"]
        nome        <- map["nome"]
        precoDe     <- map["precoDe"]
        precoPor    <- map["precoPor"]
        categoria   <- map["categoria"]
        
    }
}

class InfoProduto: Mappable{
    
    var data:[Produto]?
    
    //funçoes para modificar valores dentro da modal
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        data    <- map["data"]
    }
}
