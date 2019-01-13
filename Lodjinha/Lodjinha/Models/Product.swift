//
//  Product.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let imageUrl: String
    let description: String
    let priceBefore: Double
    let priceAfter: Double
    let category: Category?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "nome"
        case imageUrl = "urlImagem"
        case description = "descricao"
        case priceBefore = "precoDe"
        case priceAfter = "precoPor"
        case category = "categoria"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        priceBefore = try values.decodeIfPresent(Double.self, forKey: .priceBefore) ?? 0.0
        priceAfter = try values.decodeIfPresent(Double.self, forKey: .priceAfter) ?? 0.0
        category = try values.decodeIfPresent(Category.self, forKey: .category)
    }

}
