//
//  ProductApiProvider.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation
import Alamofire

typealias ProductsCallback = (@escaping () -> [Product]?) -> Void

class ProductApiProvider {
    
    static func fetchProducts(url : URL, completion : @escaping ProductsCallback) {
        
        Alamofire.request(url).validate().responseData { (response) in
            guard let data = response.data else {
                print("Failed to get data!")
                return
            }
            
            guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
                print("Failed to parse banners!")
                return
            }
            
            completion { products }
            
        }
        
    }
    
}
