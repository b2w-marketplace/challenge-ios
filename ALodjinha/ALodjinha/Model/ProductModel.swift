//
//  ProductModel.swift
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

class ProductModel: Mappable {
    
    var productId: Int!
    var name: String!
    var description: String!
    var priceFrom: Float!
    var priceTo: Float!
    var category: CategoryModel!
    var urlImage: String!
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        productId           <- map["id"]
        name                <- map["nome"]
        urlImage            <- map["urlImagem"]
        description         <- map["descricao"]
        priceFrom           <- map["precoDe"]
        priceTo             <- map["precoPor"]
        category            <- map["categoria"]
        
    }

}
