//
//  AbstractRequest.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 09/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: AbstractRequest, rhs: AbstractRequest) -> Bool {
    return false
}

/**
 A default 'abstract' class to any Request class
 */
class AbstractRequest: Equatable {
    
    /**
     The end point to make the request
     */
    var url: String!
    
    
    /**
     Converts all variables to a dictionary
     */
    func toDictionary() -> [String: Any] {
        fatalError()
    }
    
    /**
     Converts all variables to a readable string for debug
     */
    func prettyPrint() -> String {
        fatalError()
    }
    
}
