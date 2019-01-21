//
//  Product.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Product {
    var id: Int?
    var nome: String?
    var urlImagem: String?
    var descricao: String?
    var precoDe: Double?
    var precoPor: Double?
    var categoria: ProductCategory?
 
    init(id: Int? = nil, nome: String? = nil, urlImagem: String? = nil, descricao: String? = nil, precoDe: Double? = nil, precoPor: Double? = nil, categoria: ProductCategory? = nil) {
        self.id = id
        self.nome = nome
        self.urlImagem = urlImagem
        self.descricao = descricao
        self.precoDe = precoDe
        self.precoPor = precoPor
        self.categoria = categoria
    }
}
