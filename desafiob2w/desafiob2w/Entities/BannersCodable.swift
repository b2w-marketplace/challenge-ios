//
//  BannersCodable.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct BannersCodable: Codable {
    let data: [BannerCodable]
    
    struct BannerCodable: Codable {
        let id: Int
        let urlImagem: URL
        let linkUrl: URL
    }
}
