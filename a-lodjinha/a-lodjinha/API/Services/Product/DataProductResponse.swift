//
//  DataProductResponse.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: DataProductResponse, rhs: DataProductResponse) -> Bool {
    if lhs.id == nil || rhs.id == nil {
        return false
    }
    
    return lhs.id! == rhs.id!
}


class DataProductResponse: AbstractResponse {
    
    var id: Int?
    var name: String?
    var urlImagem: String?
    var description: String?
    var oldPrice: Double?
    var price: Double?
    var category: DataCategoryResponse?
    
    
    /**
     Conforms to AbstractResponse
     */
    override func mapping(map: Map) {
        
        self.id <- map["id"]
        self.name <- map["nome"]
        self.urlImagem <- map["urlImagem"]
        self.description <- map["descricao"]
        self.oldPrice <- map["precoDe"]
        self.price <- map["precoPor"]
        self.category <- map["categoria"]
    }
    
    /**
     Conforms to AbstractResponse
     */
    override func prettyPrint() -> String {
        return "DataProductResponse:\n" +
            "id: \(self.id as Optional) \n" +
            "nome: \(self.name as Optional) \n" +
            "urlImagem: \(self.urlImagem as Optional) \n" +
            "description: \(self.description as Optional) \n"
        
    }
}
