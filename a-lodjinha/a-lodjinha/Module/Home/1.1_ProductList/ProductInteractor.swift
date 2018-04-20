//
//  ProductInteractor.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class ProductInteractor {
    
    private var productAPI: ProductAPI
    
    init(productAPI: ProductAPI) {
        self.productAPI = productAPI
    }
    
    func getBestSeller(success: @escaping (_ producst: [Product]) -> (),
                    failure: @escaping (NetworkingError?) -> ()) {
        
        
        self.productAPI.getBestSellers(success: { (response) in
            
            if let _response = response {
                let products = ProductMapper.convertResponseToProductList(response: _response)
                success(products)
            }
            
        }) { (error) in
            failure(error)
        }
        
    }
    
    func getProduct(categoryID: Int,
                    success: @escaping (_ producst: [Product]) -> (),
                    failure: @escaping (NetworkingError?) -> ()) {
        
        
        self.productAPI.getProduct(categoryID: categoryID,
                                   success: { (response) in
            
            if let _response = response {
                let products = ProductMapper.convertResponseToProductList(response: _response)
                success(products)
            }
            
        }) { (error) in
            failure(error)
        }
        
    }
    
}
