//
//  ProductData.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

struct ProductData {
    
    let data: [Product]
    
    init(productDataDecodable: ProductDataDecodable) {
        data = productDataDecodable.data.map{ Product(productDecodable: $0) }
    }
    
}
