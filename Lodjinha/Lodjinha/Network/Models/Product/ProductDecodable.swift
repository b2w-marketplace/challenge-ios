//
//  ProductDecodable.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

struct ProductDecodable: Decodable {
    
    let id: Int
    let nome: String
    let urlImagem: String
    let descricao: String
    let precoDe: Float
    let precoPor: Float
    let categoria: CategoryDecodable
    
}
