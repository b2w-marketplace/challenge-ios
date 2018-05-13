//
//  MaisVendidosJson.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 10/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import Foundation

class MaisVendidosModel {
    
    var data : DataMaisVendidos?
    
    init(dictionary: [String: AnyObject]) {
        
        if let value = dictionary["data"] as? [String: AnyObject] {
            data = DataMaisVendidos(dictionary: value)
        }
    }
}
