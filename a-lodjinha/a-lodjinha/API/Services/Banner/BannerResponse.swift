//
//  ExampleResponse.swift
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
func ==(lhs: BannerResponse, rhs: BannerResponse) -> Bool {
    if lhs.data == nil || rhs.data == nil {
        return false
    }

    return lhs.data! == rhs.data!
}


class BannerResponse: AbstractResponse {
    
    var data: [DataBannerResponse]?
 
    
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
