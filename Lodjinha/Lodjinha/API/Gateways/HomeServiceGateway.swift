//
//  HomeServiceGateway.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol HomeServiceGateway {
    func loadBanners(completion: @escaping (Result<[Banner]>) -> Void)
    func loadCategories(completion: @escaping (Result<[ProductCategory]>) -> Void)
    func loadTopSellingProducts(completion: @escaping (Result<[Product]>) -> Void)
}

class HomeService: HomeServiceGateway {
    
    private let api: ApiService
    
    init(api: ApiService) {
        self.api = api
    }
    
    func loadBanners(completion: @escaping (Result<[Banner]>) -> Void) {
        api.execute(request: BannersApiRequest()) { (result: Result<ApiResponse<ApiBannerResponse>>) in
            switch result {
            case .success(let bannersResponse):
                let banners = bannersResponse.entity!.data.map({ $0.banner })
                completion(.success(banners))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadCategories(completion: @escaping (Result<[ProductCategory]>) -> Void) {
        api.execute(request: CategoriesApiRequest()) { (result: Result<ApiResponse<ApiCategoriesResponse>>) in
            switch result {
            case .success(let categoriesResponse):
                let categories = categoriesResponse.entity!.data.map({ $0.category })
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadTopSellingProducts(completion: @escaping (Result<[Product]>) -> Void) {
        api.execute(request: TopSellingProductsRequest()) { (result: Result<ApiResponse<ApiProductsResponse>>) in
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
