//
//  DataResponse.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: DataBannerResponse, rhs: DataBannerResponse) -> Bool {
    if lhs.id == nil || rhs.id == nil {
        return false
    }
    
    return lhs.id! == rhs.id!
}


class DataBannerResponse: AbstractResponse {
    
    var id: Int?
    var linkUrl: String?
    var urlImagem: String?
    
    
    /**
     Conforms to AbstractResponse
     */
    override func mapping(map: Map) {
        
        self.id <- map["id"]
        self.linkUrl <- map["linkUrl"]
        self.urlImagem <- map["urlImagem"]
        
    }
    
    /**
     Conforms to AbstractResponse
     */
    override func prettyPrint() -> String {
        return "DataResponse:\n" +
        "data: \(self.id as Optional) \n" +
        "linkUrl: \(self.linkUrl as Optional) \n" +
        "urlImagem: \(self.urlImagem as Optional) \n"
    }
}
