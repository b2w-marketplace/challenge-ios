//
//  ProductModel.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import Foundation

struct ProductModel: Decodable {
    let data: [Products]
}

struct Products: Decodable {
    let id: Int?
    let nome: String?
    let descricao: String?
    let precoDe: Double?
    let precoPor: Double?
    let urlImagem: String?
    let categoria: Category?
}
