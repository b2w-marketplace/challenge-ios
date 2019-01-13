//
//  BannerItem.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct BannerItem: Codable {
    let id: Int?
    let imageUrl: String?
    let urlLink: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case imageUrl = "urlImagem"
        case urlLink = "linkUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        urlLink = try values.decodeIfPresent(String.self, forKey: .urlLink)
    }

}
