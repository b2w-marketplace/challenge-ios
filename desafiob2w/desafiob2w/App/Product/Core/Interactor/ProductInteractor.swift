//
//  ProductInteractor.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

class ProductInteractor {
    private let productsGateway: ProductsGateway
    
    init(productsGateway: ProductsGateway) {
        self.productsGateway = productsGateway
    }
    
    func fetchProduct(idProduct: Int, completion: @escaping CompletionHandler<Product, NetworkError>) {
        productsGateway.product(url: R.string.apI.product(), idProduct: idProduct) { (result) in
            completion(result)
        }
    }
    
    func submitReserveProduct(idProduct: Int, completion: @escaping CompletionHandler<Bool, NetworkError>) {
        productsGateway.reserveProduct(url: R.string.apI.product(), idProduct: idProduct) { (result) in
            completion(result)
        }
    }
}
