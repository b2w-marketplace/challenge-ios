//
//  ApiProductsResponse.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct ApiProductsResponse: Decodable {
    
    let data: [ApiProduct]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    struct ApiProduct: Decodable {
        
        let id: Int
        let nome: String
        let urlImagem: String
        let descricao: String
        let precoDe: Double
        let precoPor: Double
        let categoria: ApiCategoriesResponse.ApiProductCategory
        
        enum CodingKeys: String, CodingKey {
            case id
            case nome
            case urlImagem
            case descricao
            case precoDe
            case precoPor
            case categoria
        }
        
        var product: Product {
            return Product(id: id, name: nome, imageUrl: urlImagem, description: descricao, priceBefore: precoDe, priceNow: precoPor, category: categoria.category)
        }
    }
    
}
