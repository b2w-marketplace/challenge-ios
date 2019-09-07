//
//  ProductResponse.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct ProductResponse {
    var data: [Product] = [Product]()
    var offset: Int = 0
    var total: Int = 0
}

extension ProductResponse: Decodable {
    enum CodingKeys: CodingKey {
        case data, offset, total
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Product].self, forKey: .data)
        offset = try container.decode(Int.self, forKey: .offset)
        total = try container.decode(Int.self, forKey: .total)
    }
}
