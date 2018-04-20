//
//  CategoryMapper.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 19/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

class CategoryMapper {
    
    static func convertResponseToCategoryList(response: CategoryResponse) -> [Category] {
        
        guard let data = response.data else {
            return []
        }
        
        var categoryList: [Category] = []
        
        for categoryResponse in data {
            
            let category: Category = Category(id: categoryResponse.id ?? 0,
                                        description: categoryResponse.description ?? "",
                                        urlImagem: categoryResponse.urlImagem ?? "")
            
            categoryList.append(category)
        }
        
        return categoryList
        
    }
    
    static func convertResponseToCategory(response: DataCategoryResponse) -> Category {
        
        let category: Category = Category(id: response.id ?? 0,
                                              description: response.description ?? "",
                                              urlImagem: response.urlImagem ?? "")
  
        return category
        
    }
    
}
