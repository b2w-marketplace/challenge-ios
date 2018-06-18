//
//  ProductsCodable.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct ProductsCodable: Codable {
    let data: [ProductCodable]
    
    struct ProductCodable: Codable {
        let id: Int
        let nome: String
        let urlImagem: String
        let descricao: String
        let precoDe: Float
        let precoPor: Float
        let categoria: CategoryCodable
        struct CategoryCodable: Codable {
            let id: Int
            let descricao: String
            let urlImagem: String
        }
    }
}
