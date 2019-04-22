//
//  HomeInteractor.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RxSwift

final class HomeInteractor: HomeInteractorProtocol {
    
    var remoteDataManager: HomeRemoteDataManagerProtocol
    
    init(remoteDataManager: HomeRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
    }
    
    var categoriesObservable: Single<[Category]> {
        return remoteDataManager.categoriesObservable
    }
    
    var bannesObservable: Single<[Banner]> {
        return remoteDataManager.bannesObservable
    }
    
    var topSellingProductListObservable: Single<[Product]> {
        return remoteDataManager.topSellingProductListObservable
    }
    
//    func fetchProducts(offset: Int, limit: Int, categoriaId: Int) -> Single<[Product]> {
//        let productEncodable = ProductEncodable(offset: offset,
//                                                limit: limit,
//                                                categoriaId: categoriaId)
//        return remoteDataManager.fetchProducts(productEncodable: productEncodable)
//    }
    
//    func fetchProductDetail(productId: Int) -> Single<Product> {
//        return remoteDataManager.fetchProductDetail(productId: productId)
//    }
    
}
