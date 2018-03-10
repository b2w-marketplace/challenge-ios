//
//  CategoryApiProvider.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation
import Alamofire

typealias CategoriesCallback = (@escaping () -> CategoryList?) -> Void

class CategoryApiProvider {
    
    static func fetchCategories(url : URL, completion : @escaping CategoriesCallback) {
        
        Alamofire.request(url).validate().responseData { (response) in
            guard let data = response.data else {
                print("Failed to get data!")
                return
            }
            
            guard let categories = try? JSONDecoder().decode(CategoryList.self, from: data) else {
                print("Failed to parse categories!")
                return
            }
            
            completion { categories }
        }
        
    }
    
}
