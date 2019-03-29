//
//  CategoryProductsApiRequest.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct CategoryProductsApiRequest: ApiRequest {
    
    let offset: Int
    let limit: Int
    let categoryId: Int
    
    init(offset: Int = 0, limit: Int = 20, categoryId: Int) {
        self.offset = offset
        self.limit = limit
        self.categoryId = categoryId
    }
    
    var urlRequest: URLRequest {
        
        let url = URL(string: "\(baseUrl)/produto?offset=\(offset)&limit=\(limit)&categoriaId=\(categoryId)")!
        let request = URLRequest(url: url)
        
        return request
    }
}
