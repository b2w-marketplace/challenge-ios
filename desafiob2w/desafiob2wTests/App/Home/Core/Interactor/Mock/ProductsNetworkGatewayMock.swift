//
//  ProductsNetworkGatewayMock.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

@testable import desafiob2w
class ProductsNetworkGatewayMock:ProductsGateway {
    var onError: Bool = true
    private let product = Product(id: 1, name: "Tv 50", urlImage: URL.init(string: "www.americanas.com.br")!, description: "TV 50 para assistir os jogos da copa", priceFrom: 4000, priceTo: 3500, category: CategoryProduct(id: 2, description: "Eletronicos", urlImage: URL.init(string: "www.americanas.com.br")!))
    
    func bestSellerProducts(url: String, completionHandler: @escaping ((Result<[Product], NetworkError>) -> Void)) {
        if onError {
            completionHandler(Result.fail(NetworkError.weakConnection))
        } else {
            completionHandler(Result.success([product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product]))
        }
        
    }
    
    func products(url: String, offset: Int, limit: Int, idCategory: Int, completionHandler: @escaping ((Result<[Product], NetworkError>) -> Void)) {
        if onError {
            completionHandler(Result.fail(NetworkError.weakConnection))
        } else {
            completionHandler(Result.success([product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product, product]))
        }
    }
    
    func product(url: String, idProduct: Int, completionHandler: @escaping ((Result<Product, NetworkError>) -> Void)) {
        if onError {
            completionHandler(Result.fail(NetworkError.weakConnection))
        } else {
            completionHandler(Result.success(product))
        }
    }
    
    func reserveProduct(url: String, idProduct: Int, completionHandler: @escaping ((Result<Bool, NetworkError>) -> Void)) {
        if onError {
            completionHandler(Result.fail(NetworkError.weakConnection))
        } else {
            completionHandler(Result.success(true))
        }
    }

}
