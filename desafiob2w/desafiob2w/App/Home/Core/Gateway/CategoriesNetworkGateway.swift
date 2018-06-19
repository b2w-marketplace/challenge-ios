//
//  CategoriesNetworkGateway.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct CategoriesNetworkGateway: CategoriesGateway {
    
    private let getRequest: GetRequestable
    
    init(getRequest: GetRequestable) {
        self.getRequest = getRequest
    }

    func categories(url: String, completionHandler: @escaping ((Result<[Category], NetworkError>) -> Void)) {
        getRequest.get(url: url) { (data, error) in
            let result = GenerateResultObjectToArray<CategoriesCodable, Category>(self.converterCategories).generate(data, error)
            completionHandler(result)
        }
    }
    
    private func converterCategories(entity: CategoriesCodable) -> [Category] {
        return entity.data.map ({
            Category(description: $0.description, urlImage: $0.urlImagem)
        })
    }
    
}
