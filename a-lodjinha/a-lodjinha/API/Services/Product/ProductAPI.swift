//
//  ProductAPI.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

class ProductAPI {
    
    var networking: AbstractNetworking
    
    init(networking: AbstractNetworking) {
        self.networking = networking
    }
    
    func getBestSellers( success: @escaping (_ responseObject: ProductResponse?) -> (),
                     failure: @escaping (NetworkingError?) -> ()) {
        
        let productRequest: ProductRequest = ProductRequest()
        productRequest.url = ConstantsService.EndPoint.Lodjinha_ProductBestSeller
        
        return self.networking.doGet(requestObject: productRequest, success: success, failure: failure)
        
    }
    
    func getProduct( categoryID: Int,
                     success: @escaping (_ responseObject: ProductResponse?) -> (),
                     failure: @escaping (NetworkingError?) -> ()) {
        
        let productRequest: ProductRequest = ProductRequest()
        productRequest.url = String.init(format: ConstantsService.EndPoint.Lodjinha_ProductByCategory, categoryID)
        
        return self.networking.doGet(requestObject: productRequest, success: success, failure: failure)
        
    }
    
}

