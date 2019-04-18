//
//  CategoryData.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

struct CategoryData {
    
    let data: [Category]
    
    init(categoryDataDecodable: CategoryDataDecodable) {
        data = categoryDataDecodable.data.map{ Category(categoryDecodable: $0) }
    }

}
