//
//  ProductAPI.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 19/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

class CategoryAPI {
    
    var networking: AbstractNetworking
    
    init(networking: AbstractNetworking) {
        self.networking = networking
    }
    
    func getCategories( success: @escaping (_ responseObject: CategoryResponse?) -> (),
                     failure: @escaping (NetworkingError?) -> ()) {
        
        let categoryRequest: CategoryRequest = CategoryRequest()
        categoryRequest.url = ConstantsService.EndPoint.Lodjinha_Category
        
        return self.networking.doGet(requestObject: categoryRequest, success: success, failure: failure)
        
    }
    
}

