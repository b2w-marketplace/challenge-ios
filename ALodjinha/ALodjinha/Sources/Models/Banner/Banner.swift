//
//  Banner.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct Banner {
    let id: Int
    let linkUrl: String
    let urlImagem: String
}

extension Banner: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case linkUrl
        case urlImagem
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        linkUrl = try container.decode(String.self, forKey: .linkUrl)
        urlImagem = try container.decode(String.self, forKey: .urlImagem)
    }
}
