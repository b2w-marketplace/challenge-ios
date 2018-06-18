//
//  HomeInteractor.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct HomeInteractor {
    
    private let categoriesGateway: CategoriesGateway
    private let productsGateway: ProductsGateway
    
    init(categoriesGateway: CategoriesGateway, productsGateway: ProductsGateway) {
        self.categoriesGateway = categoriesGateway
        self.productsGateway = productsGateway
    }
    
    func fetchCategories(completion: @escaping CompletionHandler<[Category], NetworkError>) {
        categoriesGateway.categories(url: R.string.apI.categories()) { (result) in
            completion(result)
        }
    }
    
    func fetchProductsBestSeller(completion: @escaping CompletionHandler<[Product], NetworkError>) {
        
        productsGateway.products(url: R.string.apI.productsBestSeller()) { (result) in
            completion(result)
        }
    }
}
