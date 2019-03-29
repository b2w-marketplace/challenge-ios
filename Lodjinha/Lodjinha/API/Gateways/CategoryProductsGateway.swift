//
//  CategoryProductsGateway.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol CategoryProductsGateway {
    func loadProducts(forCategoryId categoryId: Int, offset: Int, limit: Int, completion: @escaping (Result<[Product]>) -> Void)
}

class CategoryProductsService: CategoryProductsGateway {
    
    private let api: ApiService
    
    init(api: ApiService) {
        self.api = api
    }
    
    func loadProducts(forCategoryId categoryId: Int, offset: Int, limit: Int, completion: @escaping (Result<[Product]>) -> Void) {
        
        let request = CategoryProductsApiRequest(offset: offset, limit: limit, categoryId: categoryId)
        api.execute(request: request) { (result: Result<ApiResponse<ApiProductsResponse>>) in
            switch result {
            case .success(let productsResponse):
                let products = productsResponse.entity!.data.map({ $0.product })
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
