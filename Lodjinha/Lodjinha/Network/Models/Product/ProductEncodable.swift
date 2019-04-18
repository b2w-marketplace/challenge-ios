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
    
    init(offset: Int = 0, limit: Int = 10, categoriaId: Int) {
        self.offset = offset
        self.limit = limit
        self.categoriaId = categoriaId
    }
    
}
