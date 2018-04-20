//
//  CategoryResponse.swift
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
func ==(lhs: CategoryResponse, rhs: CategoryResponse) -> Bool {
    if lhs.data == nil || rhs.data == nil {
        return false
    }
    
    return lhs.data! == rhs.data!
}


class CategoryResponse: AbstractResponse {
    
    var data: [DataCategoryResponse]?
    
    
    /**
     Conforms to AbstractResponse
     */
    override func mapping(map: Map) {
        
        self.data <- map["data"]
        
    }
    
    /**
     Conforms to AbstractResponse
     */
    override func prettyPrint() -> String {
        return "CategoryResponse:\n" +
        "data: \(self.data as Optional) \n"
        
    }
}
