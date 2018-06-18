//
//  HomeViewModel.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 14/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation

class HomeViewModel: NSObject {
    
    func getBestSellerProducts(success: @escaping([Product]) -> Void, failure: @escaping(NSError) -> Void) {
        ProductManager.getProducts(categoryID: nil, bestSeller: true, success: { (products) in
            success(products)
        }) { (error) in
            failure(error)
        }
    }
    
    func getBanners(success: @escaping([Banner]) -> Void, failure: @escaping(NSError) -> Void) {
        BannerManager.getBanners(success: { (banners) in
            success(banners)
        }) { (error) in
            failure(error)
        }
    }
    
    func getCategories(success: @escaping([Category]) -> Void, failure: @escaping(NSError) -> Void) {
        CategoryManager.getCategories(success: { (categories) in
            success(categories)
        }) { (error) in
            failure(error)
        }
    }
}
