//
//  ProductRequest.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: ProductRequest, rhs: ProductRequest) -> Bool {
    return lhs.url == rhs.url
}

class ProductRequest: AbstractRequest {
    
    /**
     Conforms to AbstractRequest
     */
    override func toDictionary() -> [String : Any] {
        return [:]
    }
    
    /**
     Conforms to AbstractRequest
     */
    override func prettyPrint() -> String {
        return ""
    }
}

