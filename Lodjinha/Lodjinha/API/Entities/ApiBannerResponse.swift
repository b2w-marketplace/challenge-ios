//
//  ApiBannerResponse.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct ApiBannerResponse: Decodable {
    
    let data: [ApiBanner]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    struct ApiBanner: Decodable {
        let id: Int
        let urlImagem: String
        let linkUrl: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case urlImagem
            case linkUrl
        }
        
        var banner: Banner {
            return Banner(id: id, imageUrl: urlImagem, linkUrl: linkUrl)
        }
    }
    
}
