//
//  APIResult.swift
//  Lodjinha
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct APIResult: Decodable {
  let result: String
  let message: String?

  enum CodingKeys: String, CodingKey {
    case result
    case message = "mensagem"
  }
}
