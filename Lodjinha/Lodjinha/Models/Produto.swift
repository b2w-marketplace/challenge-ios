//
//  Produto.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
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
