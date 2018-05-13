//
//  DataMaisVendidos.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 10/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import Foundation

class DataMaisVendidos {
    
    var id : Int?
    var nome : String?
    var urlImagem : String?
    var descricao : String?
    var precoDe : Double?
    var precoPor : Float?
    var categoria : DataCategoria?
    
    init(dictionary: [String: AnyObject]) {
        
        if let value = dictionary["id"] as? Int? {
            id = value
        }
        
        if let value = dictionary["nome"] as? String? {
            nome = value
        }
        
        if let value = dictionary["urlImagem"] as? String? {
            urlImagem = value
        }
        
        if let value = dictionary["descricao"] as? String? {
            descricao = value
        }
        
        if let value = dictionary["precoDe"] as? Double? {
            precoDe = value
        }
        
        if let value = dictionary["precoPor"] as? Float? {
            precoPor = value
        }
        
        if let value = dictionary["categoria"] as? [String: AnyObject] {
            categoria = DataCategoria(dictionary: value)
        }
    }
}

