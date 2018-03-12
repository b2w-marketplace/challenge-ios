//
//  BannerList.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

struct BannerList :Codable {
    
    var data : [Banner]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
}
