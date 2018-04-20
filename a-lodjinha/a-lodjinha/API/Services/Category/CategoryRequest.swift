//
//  CategoryRequest.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 19/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: CategoryRequest, rhs: CategoryRequest) -> Bool {
    return lhs.url == rhs.url
}

class CategoryRequest: AbstractRequest {
    
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
