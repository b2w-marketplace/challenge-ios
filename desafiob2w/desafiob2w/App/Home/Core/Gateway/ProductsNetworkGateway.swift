//
//  ProductsNetworkGateway.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

class ProductsNetworkGateway: ProductsGateway {
    private let getRequest: GetRequestable
    private let postReuqest: PostRequestable
    init(getRequest: GetRequestable, postReuqest: PostRequestable) {
        self.getRequest = getRequest
        self.postReuqest = postReuqest
    }
    
    func bestSellerProducts(url: String, completionHandler: @escaping ((Result<[Product], NetworkError>) -> Void)) {
        getRequest.get(url: url) { (data, error) in
            let result = GenerateResultObjectToArray<ProductsCodable, Product>(self.converterSellerProducts).generate(data, error)
            completionHandler(result)
        }
    }
    
    func product(url: String, idProduct: Int, completionHandler: @escaping ((Result<Product, NetworkError>) -> Void)) {
        getRequest.get(url: url+"\(idProduct)") { (data, error) in
            let result = GenerateResultObjectToObject<ProductCodable, Product>(self.converterProduct).generate(data, error)
            completionHandler(result)
        }
    }
    
    func products(url: String, offset: Int, limit: Int, idCategory: Int, completionHandler: @escaping ((Result<[Product], NetworkError>) -> Void)) {
        getRequest.get(url: url+"?offset=\(offset)&limit=\(limit)&categoriaId=\(idCategory)") { (data, error) in
            let result = GenerateResultObjectToArray<ProductsCodable, Product>(self.converterSellerProducts).generate(data, error)
            completionHandler(result)
        }
    }
    
    func reserveProduct(url: String, idProduct: Int, completionHandler: @escaping ((Result<Bool, NetworkError>) -> Void)) {
        postReuqest.post(url: url+"\(idProduct)") { (data, error) in
            let result = GenerateResultObjectToObject<SuccesCodable, Bool>(self.converterReserveProduct).generate(data, error)
            completionHandler(result)
        }
    }
    
    private func converterReserveProduct(entity: SuccesCodable) -> Bool {
        return entity.result != "succes"
    }
    
    private func converterProduct(entity: ProductCodable) -> Product {
        return Product(id: entity.id, name: entity.name, urlImage: entity.urlImagem, description: entity.description, priceFrom: entity.priceFrom, priceTo: entity.priceTo, category: Category(id: entity.category.id, description: entity.category.description, urlImage: entity.category.urlImagem))
    }
    
    private func converterProducts(entity: ProductsCodable) -> [Product] {
        
        return entity.data.map({
            Product.init(id: $0.id, name: $0.name, urlImage: $0.urlImagem, description: $0.description, priceFrom: $0.priceFrom, priceTo: $0.priceTo, category: Category(id: $0.category.id, description: $0.category.description, urlImage: $0.category.urlImagem))
        })
    }
    
    private func converterSellerProducts(entity: ProductsCodable) -> [Product] {
        return entity.data.map({
            Product.init(id: $0.id, name: $0.name, urlImage: $0.urlImagem, description: $0.description, priceFrom: $0.priceFrom, priceTo: $0.priceTo, category: Category(id: $0.category.id, description: $0.category.description, urlImage: $0.category.urlImagem))
        })
    }
}
