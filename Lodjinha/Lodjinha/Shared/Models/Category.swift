//
//  Category.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Category: Decodable {
  let identifier: Int
  let description: String
  let imageUrl: String

  enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case description = "descricao"
    case imageUrl = "urlImagem"
  }
}
