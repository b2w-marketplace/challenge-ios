//
//  CategoryModel.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import Foundation

struct CategoryModel: Decodable {
    let data: [Category]
}

struct Category: Decodable {
    let id: Int?
    let descricao: String?
    let urlImagem: String?
    
}
