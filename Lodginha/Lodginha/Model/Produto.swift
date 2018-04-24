//
//  Produto.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 17/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import Foundation

struct Produto: Codable {
    let id: Int
    let nome: String
    let descricao: String
    let precoDe: Double
    let precoPor: Double
    let urlImagem: String
    let categoria: Categoria
}
