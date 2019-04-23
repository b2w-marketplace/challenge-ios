//
//  ProductDetailInteractor.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RxSwift

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    private let remoteDataManager: ProductDetailRemoteDataManagerProtocol
    
    let product: Product
    
    var title: String {
        return product.categoria.descricao
    }
    
    init(product: Product, remoteDataManager: ProductDetailRemoteDataManagerProtocol) {
        self.product = product
        self.remoteDataManager = remoteDataManager
    }
    
    var productDetailObservable: Single<Product> {
        return remoteDataManager.fetchProductDetail(productId: product.id)
    }
    
    func productReservation() -> Completable {
        return remoteDataManager.productReservation(productId: product.id)
    }

}
