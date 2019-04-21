//
//  Product.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct Product: Codable {
    var categoria: Category
    var descricao: String
    var id: Int
    var nome: String
    var precoDe: Double
    var precoPor: Double
    var urlImagem: String
}
