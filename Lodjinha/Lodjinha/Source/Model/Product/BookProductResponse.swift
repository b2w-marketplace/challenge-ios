//
//  BookProductResponse.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 11/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

struct BookProductResponse : Codable {
    var result : String
    
    enum CodingKeys : String, CodingKey {
        case result
    }
    
}
