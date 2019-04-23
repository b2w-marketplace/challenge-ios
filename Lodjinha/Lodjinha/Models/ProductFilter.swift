//
//  ProductFilter.swift
//  Lodjinha
//
//  Created by Marcos on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

final class ProductFilter {
    
    var offset: Int
    var limit: Int
    let categoriaId: Int
    
    init(categoriaId: Int, offset: Int = 0, limit: Int = 20) {
        self.categoriaId = categoriaId
        self.offset = offset
        self.limit = limit
    }
    
}
