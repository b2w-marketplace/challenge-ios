//
//  ProductApiProvider.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation
import Alamofire

typealias ProductsCallback = (@escaping () -> ProductList?) -> Void
typealias ProductDetailCallback = (@escaping () -> Product?) -> Void
typealias BookProductCallback = (@escaping () -> BookProductResponse?) -> Void

class ProductApiProvider {
    
    static func fetchProducts(url : URL, completion : @escaping ProductsCallback) {
        
        Alamofire.request(url).validate().responseData { (response) in
            guard let data = response.data else {
                print("Failed to get data!")
                return
            }

            guard let products = try? JSONDecoder().decode(ProductList.self, from: data) else {
                print("Failed to parse products!")
                return
            }

            completion { products }

        }
        
    }
    
    static func getProductDetails(url : URL, completion : @escaping ProductDetailCallback) {
        
        Alamofire.request(url).validate().responseData { (response) in
            guard let data = response.data else {
                print("Failed to get data!")
                return
            }
            
            guard let product = try? JSONDecoder().decode(Product.self, from: data) else {
                print("Failed to parse product detail!")
                return
            }
            
            completion { product }
        }
        
    }
    
    static func bookProduct(url : URL, completion : @escaping BookProductCallback) {
        
        Alamofire.request(url, method: .post, encoding: URLEncoding.httpBody).validate().responseData { (response) in
            guard let data = response.data else {
                print("Failed to get data!")
                return
            }
            
            guard let bookResponse = try? JSONDecoder().decode(BookProductResponse.self, from: data) else {
                print("Failed to parse book response!")
                return
            }
            
            completion { bookResponse }
            
        }
        
    }
    
}
