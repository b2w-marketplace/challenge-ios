//
//  ProductDetailRemoteDataManager.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RxSwift

final class ProductDetailRemoteDataManager: ProductDetailRemoteDataManagerProtocol {
    
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    private var productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }
    
    func fetchProductDetail(productId: Int) -> Single<Product> {
        return productService.fetchProductDetail(productId: productId, scheduler: scheduler)
            .map{ Product(productDecodable: $0) }
    }
    
    func productReservation(productId: Int) -> Completable {
        return productService.productReservation(productId: productId, scheduler: scheduler)
    }
    
}
