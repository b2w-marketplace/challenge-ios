//
//  BannerModel.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Foundation
import Gloss

class BannerResponseModel: JSONDecodable {
    
    let banners: [BannerModel]!
    
    required init?(json: JSON) {
        guard let banners: [BannerModel] = "data" <~~ json else {
            return nil
        }
        self.banners = banners
    }
    
}

class BannerModel: JSONDecodable {
    
    let id: Int!
    let linkUrl: String!
    let imgUrl: String!
    
    required init?(json: JSON) {
        guard let id: Int = "id" <~~ json,
            let linkUrl: String = "linkUrl" <~~ json,
            let imgUrl: String = "urlImagem" <~~ json else {
                return nil
        }
        
        self.id = id
        self.linkUrl = linkUrl
        self.imgUrl = imgUrl
    }
    
}
