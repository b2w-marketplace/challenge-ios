//
//  Banner.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

struct Banner : Codable {
    var id : Int
    var imageUrl : String
    var linkUrl : String
    
    enum BannersKeys: String, CodingKey {
        case id
        case imageUrl = "urlImagem"
        case linkUrl
    }
}

