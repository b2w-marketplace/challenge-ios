//
//  ProductInfoViewModel.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct ProductInfoViewModel {
    let product: Product

    let beforePrice: String
    let afterPrice: String

    init(product: Product) {
        self.product = product
        beforePrice = String(format: "De: %.2f", product.priceBefore)
        afterPrice = String(format: "Por %.2f", product.priceAfter)
    }

}
