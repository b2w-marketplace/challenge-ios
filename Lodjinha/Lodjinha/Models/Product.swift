//
//  Product.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

struct Product {
    
    let id: Int
    let nome: String
    let urlImagem: String
    let descricao: String
    let precoDe: Float
    let precoPor: Float
    let categoria: Category
    
    init(productDecodable: ProductDecodable) {
        id = productDecodable.id
        nome = productDecodable.nome
        urlImagem = productDecodable.urlImagem
        descricao = productDecodable.descricao
        precoDe = productDecodable.precoDe
        precoPor = productDecodable.precoPor
        categoria = Category(categoryDecodable: productDecodable.categoria)
    }
    
}
