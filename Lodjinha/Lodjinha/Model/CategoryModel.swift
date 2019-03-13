//
//  CategoryModel.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

struct CategoryModel: Decodable {
    let id: Int
    let imageUrl: URL
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "urlImagem"
        case description = "descricao"
    }
}
