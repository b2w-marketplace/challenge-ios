//
//  Category.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

struct Category : Codable {
    var id : Int
    var description : String
    var imageUrl : String
    
    init() {
        self.id = 0
        self.description = ""
        self.imageUrl = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "descricao"
        case imageUrl = "urlImagem"
    }
}
