//
//  ProducListInteractor.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RxSwift

final class ProducListInteractor: ProducListInteractorProtocol {
    
    private let repository: ProducListRepositoryProtocol
    
    var numberOfProducts: Int {
        return repository.numberOfProducts
    }
    
    init(repository: ProducListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchProducts(withFilter filter: ProductFilter) -> Single<[Product]> {
        return repository.fetchProducts(withFilter: filter)
    }
    
    func product(at index: Int) -> Product {
        return repository.product(at: index)
    }
    
}
