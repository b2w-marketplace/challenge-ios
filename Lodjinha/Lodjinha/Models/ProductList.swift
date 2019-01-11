//
//  ProductList.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct ProductList: Codable {
    let products: [Product]
    let offset: Int
    let total: Int

    enum CodingKeys: String, CodingKey {

        case products = "data"
        case offset = "offset"
        case total = "total"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Product].self, forKey: .products) ?? []
        offset = try values.decodeIfPresent(Int.self, forKey: .offset) ?? 0
        total = try values.decodeIfPresent(Int.self, forKey: .total) ?? 0
    }

}
