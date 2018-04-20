//
//  TopServiceRequest.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 29/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//


import Foundation

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: BannerRequest, rhs: BannerRequest) -> Bool {
    return lhs.url == rhs.url
}

class BannerRequest: AbstractRequest {
    
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
