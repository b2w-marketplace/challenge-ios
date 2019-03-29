//
//  ApiCategoriesResponse.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct ApiCategoriesResponse: Decodable {
    
    let data: [ApiProductCategory]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    struct ApiProductCategory: Decodable {
        
        let id: Int
        let descricao: String
        let urlImagem: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case descricao
            case urlImagem
        }
        
        var category: ProductCategory {
            return ProductCategory(id: id, description: descricao, imageUrl: urlImagem)
        }
    }
    
}
