//
//  Categoria.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation

struct Categoria: Codable {
    let id: Int
    let descricao: String
    let urlImagem: String
}

struct DataCategory:Codable{
    let data : [Categoria]
}
