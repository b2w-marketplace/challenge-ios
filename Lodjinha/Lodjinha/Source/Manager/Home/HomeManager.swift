//
//  HomeManager.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

class HomeManager: BaseManager {
    
    private lazy var bannerBusiness : BannerBusiness = {
        return BannerBusiness()
    }()
    
    private lazy var categoryBusiness : CategoryBusiness = {
        return CategoryBusiness()
    }()
    
    private lazy var productBusiness : ProductBusiness = {
        return ProductBusiness()
    }()
    
    public func fetchBanners(completion : @escaping BannerCallback) {
        addOperation {
            self.bannerBusiness.fetchBanners(completion: { (banners) in
                OperationQueue.main.addOperation {
                    completion(banners)
                }
            })
        }
    }
    
    public func fetchCategories(completion : @escaping CategoriesCallback) {
        addOperation {
            self.categoryBusiness.fetchCategories(completion: { (categories) in
                OperationQueue.main.addOperation {
                    completion(categories)
                }
            })
        }
    }
    
    public func fetchTopSelledProducts(completion : @escaping ProductsCallback) {
        addOperation {
            self.productBusiness.fetchTopSelledProducts(completion: { (products) in
                OperationQueue.main.addOperation {
                    completion(products)
                }
            })
        }
    }
    
}
