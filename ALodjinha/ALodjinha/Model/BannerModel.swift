//
//  BannerModel.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import ObjectMapper
import Kingfisher
import RxSwift
import RxCocoa

class BannerModel: Mappable {
    
    var bannerId: Int!
    var linkUrl: String!
    var urlImage: String!
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        bannerId            <- map["id"]
        linkUrl             <- map["linkUrl"]
        urlImage            <- map["urlImagem"]
        
    }

}
