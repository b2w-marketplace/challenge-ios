//
//  BannerModel.swift
//  MoyaTest
//
//  Created by Gustavo Azevedo de Oliveira on 09/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

struct BannerModel: Decodable {
    let id: Int
    let linkUrl: URL
    let imageUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case linkUrl
        case imageUrl = "urlImagem"
    }
}
