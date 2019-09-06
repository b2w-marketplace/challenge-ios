//
//  CategoriesResponse.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct CategoriesResponse {
    var data: [Category] = [Category]()
}

extension CategoriesResponse: Decodable {
    enum CodingKeys: CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Category].self, forKey: .data)
    }
}
