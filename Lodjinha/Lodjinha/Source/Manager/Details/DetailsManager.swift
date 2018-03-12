//
//  DetailsManager.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 11/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

class DetailsManager : BaseManager {
    
    private lazy var productBusiness : ProductBusiness = {
        return ProductBusiness()
    }()
    
    public func getProductDetails(forIdentifier id : Int, completion : @escaping ProductDetailCallback) {
        addOperation {
            self.productBusiness.getProductDetail(forIdentifier: id, completion: { (product) in
                OperationQueue.main.addOperation {
                    completion(product)
                }
            })
        }
    }
    
}
