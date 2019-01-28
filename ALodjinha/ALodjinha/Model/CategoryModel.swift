//
//  CategoryModel.swift
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

class CategoryModel: Mappable {
    
    var categoryId: Int!
    var description: String!
    var urlImage: String!
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        categoryId          <- map["id"]
        description         <- map["descricao"]
        urlImage            <- map["urlImagem"]
        
    }

}
