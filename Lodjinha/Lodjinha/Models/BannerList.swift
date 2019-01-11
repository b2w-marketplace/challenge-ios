//
//  BannerList.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct BannerList: Codable {
    let bannerItems: [BannerItem]?

    enum CodingKeys: String, CodingKey {

        case bannerItems = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bannerItems = try values.decodeIfPresent([BannerItem].self, forKey: .bannerItems)
    }

}
