//
//  ProductsByCategoryManager.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 11/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

class ProductsByCategoryManager: BaseManager {

    private lazy var productBusiness : ProductBusiness = {
        return ProductBusiness()
    }()
    
    public func fetchProductsList(forCategory id: Int, completion : @escaping ProductsCallback) {
        addOperation {
            self.productBusiness.getProductsList(forCategory: id, completion: { (productList) in
                completion(productList)
            })
        }
    }
    
}
