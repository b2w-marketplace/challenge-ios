//
//  ProductsInteractor.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 20/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

class ProductsInteractor {
    private let productsGateway: ProductsGateway
    private var productsOffset = 0
    private let productLimit = 20
    init(productsGateway: ProductsGateway) {
        self.productsGateway = productsGateway
    }
    
    func fetchProducts(idCategory: Int, completion: @escaping CompletionHandler<[Product], NetworkError>) {
        productsGateway.products(url: R.string.apI.product(), offset: productsOffset, limit: productLimit, idCategory: idCategory) { (result) in
            if case let .success(products) = result {
               self.changeOffset(offSet: products.count)
            }
            completion(result)
        }
    }
    
    private func changeOffset(offSet: Int) {
        productsOffset += offSet
    }
}


