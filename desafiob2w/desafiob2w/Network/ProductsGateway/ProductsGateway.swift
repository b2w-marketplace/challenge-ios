//
//  ProductsGateway.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

protocol ProductsGateway {
    func bestSellerProducts(url: String, completionHandler: @escaping CompletionHandler<[Product], NetworkError>)
    func products(url: String, offset: Int, limit: Int, idCategory: Int, completionHandler: @escaping ((Result<[Product], NetworkError>) -> Void)) 
    func product(url: String, idProduct: Int, completionHandler: @escaping CompletionHandler<Product, NetworkError>)
    func reserveProduct(url: String, idProduct: Int,  completionHandler: @escaping CompletionHandler<Bool, NetworkError>)
}
