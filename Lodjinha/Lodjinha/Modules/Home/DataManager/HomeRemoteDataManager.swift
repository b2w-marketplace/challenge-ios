//
//  HomeLocalDataManager.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RxSwift

final class HomeRemoteDataManager: HomeRemoteDataManagerProtocol {
    
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    private var productService: ProductServiceProtocol
    private var categoryService: CategoryServiceProtocol
    private var bannerService: BannerServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductService(),
         categoryService: CategoryServiceProtocol = CategoryService(),
         bannerService: BannerServiceProtocol = BannerService()) {
        self.productService = productService
        self.categoryService = categoryService
        self.bannerService = bannerService
    }
    
    // MARK: - CategoryService
    var categoriesObservable: Single<[Category]> {
        return categoryService.fetchCategories(scheduler: scheduler)
            .map{ CategoryData(categoryDataDecodable: $0).data }
    }
    
    // MARK: - BannerService
    var bannesObservable: Single<[Banner]> {
        return bannerService.fetchBannes(scheduler: scheduler)
            .map{ BannerData(bannerDataDecodable: $0).data }
    }

    // MARK: - ProductService
    var topSellingProductListObservable: Single<[Product]> {
        return productService.fetchTopSellingProducts(scheduler: scheduler)
            .map{ ProductData(productDataDecodable: $0).data }
    }

}
