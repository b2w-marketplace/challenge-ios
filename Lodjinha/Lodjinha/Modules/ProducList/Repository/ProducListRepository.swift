//
//  ProducListRepository.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import  RxSwift

final class ProducListRepository: ProducListRepositoryProtocol {
    
    private let remoteDataManager: ProducListRemoteDataManagerProtocol
    
    private var productList: [Product] = []
    
    var numberOfProducts: Int {
        return productList.count
    }
    
    init(remoteDataManager: ProducListRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
    }
    
    func fetchProducts(withFilter filter: ProductFilter) -> Single<[Product]> {
        let productEncodable = ProductEncodable(productFilter: filter)
        return remoteDataManager.fetchProducts(productEncodable: productEncodable)
            .map({ productDecodableList -> [Product] in
                productDecodableList.map { Product(productDecodable: $0) }
            })
            .do(onSuccess: { [weak self] productList in
                if filter.offset == 0 {
                    self?.productList = productList
                } else {
                    self?.productList.append(contentsOf: productList)
                }
            })
    }
    
    func product(at index: Int) -> Product {
        return productList[index]
    }
    
}
