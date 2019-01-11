//
//  Category.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int
    let description: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case description = "descricao"
        case imageUrl = "urlImagem"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
    }

}
