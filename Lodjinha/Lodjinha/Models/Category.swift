//
//  Category.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

struct Category {
    
    let id: Int
    let descricao: String
    let urlImagem: String
    
    init(categoryDecodable: CategoryDecodable) {
        id = categoryDecodable.id
        descricao = categoryDecodable.descricao
        urlImagem = categoryDecodable.urlImagem
    }
    
}
