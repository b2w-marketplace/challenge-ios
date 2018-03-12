//
//  CategoryBusiness.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

class CategoryBusiness {
    
    private var categories : CategoryList?
    
    public func fetchCategories(completion : @escaping CategoriesCallback) {
        
        guard let url = URL(string: ApiProvider.categoryUrl) else {
            print("Failed to get url")
            return
        }
        
        CategoryApiProvider.fetchCategories(url: url) { (categories) in
            
            self.categories = categories()
            
            completion { self.categories }
            
        }
    }
    
}
