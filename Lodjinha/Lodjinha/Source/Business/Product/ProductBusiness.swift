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
    private var selectedProduct : Product?
    
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
    
    public func getProductDetail(forIdentifier id : Int, completion : @escaping ProductDetailCallback) {
        
        guard let url = URL(string: ApiProvider.productUrl + String(describing: id)) else {
            print("Failed to get url")
            return
        }
        
        ProductApiProvider.getProductDetails(url: url) { (product) in
            
            self.selectedProduct = product()
            
            completion { self.selectedProduct }
            
        }
        
    }
    
    public func getProductsList(forCategory id : Int, completion: @escaping ProductsCallback) {
        guard let url = URL(string: ApiProvider.productsOfCategoryUrl + String(describing: id)) else {
            print("Failed to get url")
            return
        }
        
        ProductApiProvider.fetchProducts(url: url) { (products) in
            
            self.allProductsByCategory = products()
            
            completion { self.allProductsByCategory }
            
        }
        
    }
    
}
