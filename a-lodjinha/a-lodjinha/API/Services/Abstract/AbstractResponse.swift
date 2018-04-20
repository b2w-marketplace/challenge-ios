//
//  File.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 09/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: AbstractResponse, rhs: AbstractResponse) -> Bool {
    return false
}

/**
 A default 'abstract' class to any Response class
 */
class AbstractResponse: Mappable, Equatable {
    
    /**
     Default constructor
     */
    init() {}
    
    /**
     Conforms to Mappable
     */
    required init?(map: Map) { }
    
    
    /**
     Conforms to Mappable
     */
    func mapping(map: Map){
        fatalError()
    }
    
    /**
     Converts all variables to a readable string for debug
     */
    func prettyPrint() -> String {
        fatalError()
    }
    
}
