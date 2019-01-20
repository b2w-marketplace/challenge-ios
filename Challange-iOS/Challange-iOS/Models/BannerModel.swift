//
//  BannerModel.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import Foundation


struct BannerModel: Decodable {
    let data: [Banner]
}

struct Banner: Decodable {
    let id: Int?
    let linkUrl: String?
    let urlImagem: String?
    
}
