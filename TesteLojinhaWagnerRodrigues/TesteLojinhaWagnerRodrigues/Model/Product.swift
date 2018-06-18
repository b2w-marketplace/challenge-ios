//
//  Product.swift
//  TesteLojinhaWagnerRodrigues
//
//  Created by Wagner Rodrigues on 10/06/2018.
//  Copyright © 2018 Wagner Rodrigues. All rights reserved.
//

import Foundation

struct Product: Decodable {
    
    let categoria: Category
    let descricao: String
    let id: Int
    let nome: String
    let precoDe: Int
    let precoPor: Int
    let urlImagem: String
}

