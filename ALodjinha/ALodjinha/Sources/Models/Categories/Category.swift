//
//  Category.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct Category {
    let descricao: String
    let id: Int
    let urlImagem: String
}

extension Category: Decodable {
    enum CodingKeys: CodingKey {
        case descricao
        case id
        case urlImagem
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        descricao = try container.decode(String.self, forKey: .descricao)
        id = try container.decode(Int.self, forKey: .id)
        urlImagem = try container.decode(String.self, forKey: .urlImagem)
    }
}
