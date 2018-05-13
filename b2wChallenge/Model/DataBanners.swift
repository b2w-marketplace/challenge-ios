//
//  DataBanners.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 10/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import Foundation

class DataBanners {
    
    var id : Int?
    var linkUrl : String?
    var urlImagem : String?
    
    init(dictionary: [String: AnyObject]) {
        
        if let value = dictionary["id"] as? Int? {
            id = value
        }
        
        if let value = dictionary["linkUrl"] as? String? {
            linkUrl = value
        }
        
        if let value = dictionary["urlImagem"] as? String? {
            urlImagem = value
        }
    }
}
