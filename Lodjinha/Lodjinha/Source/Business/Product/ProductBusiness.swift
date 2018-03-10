//
//  ProductBusiness.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

class ProductBusiness {
    
    private var topSelledProducts : ProductList?
    private var allProductsByCategory : ProductList?
    
    public func fetchTopSelledProducts(completion : @escaping ProductsCallback) {
        
        guard let url = URL(string: ApiProvider.topSelledProductsUrl) else {
            print("Failed to get url")
            return
        }
        
        ProductApiProvider.fetchProducts(url: url) { (products) in
            
            self.topSelledProducts = products()
            
            completion { self.topSelledProducts }
            
        }
        
    }
    
}
