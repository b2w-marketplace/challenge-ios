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
    
    var bannerList: [Banner] = []
    var categoryList: [Category] = []
    var productList: [Product] = []
    
    init(productService: ProductServiceProtocol = ProductService(),
         categoryService: CategoryServiceProtocol = CategoryService(),
         bannerService: BannerServiceProtocol = BannerService()) {
        self.productService = productService
        self.categoryService = categoryService
        self.bannerService = bannerService
    }
    
    // MARK: - BannerService
    var bannersObservable: Single<[Banner]> {
        return bannerService.fetchBannes(scheduler: scheduler)
            .map{ BannerData(bannerDataDecodable: $0).data }
            .do(onSuccess: { [weak self] bannerList in
                self?.bannerList.append(contentsOf: bannerList)
            })
    }
    
    // MARK: - CategoryService
    var categoriesObservable: Single<[Category]> {
        return categoryService.fetchCategories(scheduler: scheduler)
            .map{ CategoryData(categoryDataDecodable: $0).data }
            .do(onSuccess: { [weak self] categoryList in
                self?.categoryList = categoryList
            })
    }

    // MARK: - ProductService
    var topSellingProductListObservable: Single<[Product]> {
        return productService.fetchTopSellingProducts(scheduler: scheduler)
            .map{ ProductData(productDataDecodable: $0).data }
            .do(onSuccess: { [weak self] productList in
                self?.productList = productList
            })
    }

    func loadData() -> Completable {
        return bannersObservable
            .asCompletable()
            .andThen(categoriesObservable)
            .asCompletable()
            .andThen(topSellingProductListObservable)
            .asCompletable()
    }
    
}
