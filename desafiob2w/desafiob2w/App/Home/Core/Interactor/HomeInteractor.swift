//
//  HomeInteractor.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

class HomeInteractor {
    
    private let categoriesGateway: CategoriesGateway
    private let productsGateway: ProductsGateway
    private let bannersGateway: BannersGateway
    
    init(categoriesGateway: CategoriesGateway, productsGateway: ProductsGateway, bannersGateway: BannersGateway) {
        self.categoriesGateway = categoriesGateway
        self.productsGateway = productsGateway
        self.bannersGateway = bannersGateway
    }
    
    func fetchCategories(completion: @escaping CompletionHandler<[CategoryProduct], NetworkError>) {
        categoriesGateway.categories(url: R.string.apI.categories()) { (result) in
            completion(result)
        }
    }
    
    func fetchProductsBestSeller(completion: @escaping CompletionHandler<[Product], NetworkError>) {

        productsGateway.bestSellerProducts(url: R.string.apI.productsBestSeller()) { (result) in
            completion(result)
        }
    }
    
    func fetchBanners(completion: @escaping CompletionHandler<[Banner], NetworkError>) {
        bannersGateway.banners(url: R.string.apI.banners()) { (result) in
            completion(result)
        }
    }
}
