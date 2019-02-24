//
//  Product.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Product: Decodable {
  let identifier: Int
  let name: String
  let imageUrl: String
  let description: String
  let fromPrice: Double
  let toPrice: Double
  let category: Category

  enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case name = "nome"
    case imageUrl = "urlImagem"
    case description = "descricao"
    case fromPrice = "precoDe"
    case toPrice = "precoPor"
    case category = "categoria"
  }
}
