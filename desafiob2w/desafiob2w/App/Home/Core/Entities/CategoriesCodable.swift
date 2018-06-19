//
//  CategoriesCodable.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct CategoriesCodable: Codable {
    let data: [CategoryCodable]
    
    struct CategoryCodable: Codable {
        let id: Int
        let description: String
        let urlImagem: URL
        
        enum CodingKeys: String, CodingKey {
            case id
            case description = "descricao"
            case urlImagem = "urlImagem"
        }
    }
}
