//
//  BannerData.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

struct BannerData {
    
    let data: [Banner]
    
    init(bannerDataDecodable: BannerDataDecodable) {
        data = bannerDataDecodable.data.map{ Banner(bannerDecodable: $0) }
    }
    
}
