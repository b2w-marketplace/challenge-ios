//
//  Banners.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 10/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import Foundation

class Banners {
    
    var data : DataBanners?
    
    init(dictionary: [String: AnyObject]) {
        
        if let value = dictionary["data"] as? [String: AnyObject] {
            data = DataBanners(dictionary: value)
        }
    }
}
