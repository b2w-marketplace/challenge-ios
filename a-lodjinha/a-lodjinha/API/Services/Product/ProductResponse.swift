//
//  ProductResponse.swift
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
func ==(lhs: ProductResponse, rhs: ProductResponse) -> Bool {
    if lhs.data == nil || rhs.data == nil {
        return false
    }
    
    return lhs.data! == rhs.data!
}


class ProductResponse: AbstractResponse {
    
    var data: [DataProductResponse]?
    
    
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
        return "BannerResponse:\n" +
        "data: \(self.data as Optional) \n"
        
    }
}
