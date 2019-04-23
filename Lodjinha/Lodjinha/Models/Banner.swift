//
//  Banner.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

struct Banner {
    
    let id: Int
    let urlImagem: String
    let linkUrl: String
    
    init(bannerDecodable: BannerDecodable) {
        id = bannerDecodable.id
        urlImagem = bannerDecodable.urlImagem
        linkUrl = bannerDecodable.linkUrl
    }
    
}
