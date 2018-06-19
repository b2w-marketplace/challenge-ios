//
//  ProductsNetworkGateway.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct ProductsNetworkGateway: ProductsGateway {
    
    private let getRequest: GetRequestable
    init(getRequest: GetRequestable) {
        self.getRequest = getRequest
    }
    
    func products(url: String, completionHandler: @escaping ((Result<[Product], NetworkError>) -> Void)) {
        getRequest.get(url: url) { (data, error) in
            let result = GenerateResultObjectToArray<ProductsCodable, Product>(self.converterProducts).generate(data, error)
            completionHandler(result)
        }
    }
    
    private func converterProducts(entity: ProductsCodable) -> [Product] {
        return entity.data.map({
            Product.init(name: $0.name, urlImage: $0.urlImagem, description: $0.description, priceFrom: $0.priceFrom, priceTo: $0.priceTo, category: Category(description: $0.category.description, urlImage: $0.category.urlImagem))
        })
    }
}
