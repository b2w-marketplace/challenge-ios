//
//  DisplayedProduct.swift
//  Lodjinha
//
//  Created by Gilson Gil on 24/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct DisplayedProduct {
  let imageUrl: String
  let name: String
  let fromPrice: String
  let toPrice: String
  let description: String

  init(imageUrl: String, name: String, fromPrice: String, toPrice: String, description: String = "") {
    self.imageUrl = imageUrl
    self.name = name
    self.fromPrice = fromPrice
    self.toPrice = toPrice
    self.description = description
  }
}
