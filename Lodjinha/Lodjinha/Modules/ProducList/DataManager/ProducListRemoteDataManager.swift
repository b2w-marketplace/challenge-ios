//
//  ProducListRemoteDataManager.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RxSwift

final class ProducListRemoteDataManager: ProducListRemoteDataManagerProtocol {
    
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    private var productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }
    
    func fetchProducts(productEncodable: ProductEncodable) -> Single<[ProductDecodable]> {
        return productService.fetchProducts(productEncodable: productEncodable, scheduler: scheduler)
            .map{ $0.data }
    }
    
}
