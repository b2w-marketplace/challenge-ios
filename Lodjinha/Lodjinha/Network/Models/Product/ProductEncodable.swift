//
//  ProductEncodable.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

struct ProductEncodable: Encodable {
    
    let offset: Int
    let limit: Int
    let categoriaId: Int
    
    init(categoriaId: Int, offset: Int = 0, limit: Int = 10) {
        self.offset = offset
        self.limit = limit
        self.categoriaId = categoriaId
    }
    
    init(productFilter: ProductFilter) {
        offset = productFilter.offset
        limit = productFilter.limit
        categoriaId = productFilter.categoriaId
    }
    
}
