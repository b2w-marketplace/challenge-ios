//
//  CategoryModel.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Foundation
import Gloss

class CategoryResponseModel: JSONDecodable {
    
    let categories: [CategoryModel]!
    
    required init?(json: JSON) {
        guard let categories: [CategoryModel] = "data" <~~ json else {
            return nil
        }
        self.categories = categories
    }
    
}

class CategoryModel: JSONDecodable {
    
    let id: Int!
    let description: String!
    let imgUrl: String!
    
    required init?(json: JSON) {
        guard let id: Int = "id" <~~ json,
            let description: String = "descricao" <~~ json,
            let imgUrl: String = "urlImagem" <~~ json else {
                return nil
        }
        
        self.id = id
        self.description = description
        self.imgUrl = imgUrl
    }
    
}
