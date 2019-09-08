//
//  Product.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct Product {
    let id: Int
    let nome: String
    let urlImagem: String
    let descricao: String
    let precoDe: Double
    let precoPor: Double
    let categoria: Category
}

extension Product: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case nome
        case urlImagem
        case descricao
        case precoDe
        case precoPor
        case categoria
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        nome = try container.decode(String.self, forKey: .nome)
        urlImagem = try container.decode(String.self, forKey: .urlImagem)
        descricao = try container.decode(String.self, forKey: .descricao)
        precoDe = try container.decode(Double.self, forKey: .precoDe)
        precoPor = try container.decode(Double.self, forKey: .precoPor)
        categoria = try container.decode(Category.self, forKey: .categoria)
    }
}
