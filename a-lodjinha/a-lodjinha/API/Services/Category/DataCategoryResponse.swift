//
//  DataCategoryResponse.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 19/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: DataCategoryResponse, rhs: DataCategoryResponse) -> Bool {
    if lhs.id == nil || rhs.id == nil {
        return false
    }
    
    return lhs.id! == rhs.id!
}


class DataCategoryResponse: AbstractResponse {
    
    var id: Int?
    var description: String?
    var urlImagem: String?
    
    
    /**
     Conforms to AbstractResponse
     */
    override func mapping(map: Map) {
        
        self.id <- map["id"]
        self.description <- map["descricao"]
        self.urlImagem <- map["urlImagem"]
        
    }
    
    /**
     Conforms to AbstractResponse
     */
    override func prettyPrint() -> String {
        return "DataCategoryResponse:\n" +
            "data: \(self.id as Optional) \n" +
            "description: \(self.description as Optional) \n" +
            "urlImagem: \(self.urlImagem as Optional) \n"
    }
}

