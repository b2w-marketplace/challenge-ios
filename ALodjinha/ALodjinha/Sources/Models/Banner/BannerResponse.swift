//
//  BannerResponse.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct BannerResponse {
    var data: [Banner] = [Banner]()
}

extension BannerResponse: Decodable {
    enum CodingKeys: CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Banner].self, forKey: .data)
    }
}
