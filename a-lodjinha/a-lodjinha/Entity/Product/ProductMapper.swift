//
//  ProductMapper.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

class ProductMapper {
    
    static func convertResponseToProductList(response: ProductResponse) -> [Product] {
        
        guard let data = response.data else {
            return []
        }
        
        var productList: [Product] = []
        
        for productResponse in data {
            
            
            guard let categoryResponse = productResponse.category else {
                return []
            }
            
             let category: Category = CategoryMapper.convertResponseToCategory(response: categoryResponse)
            
            let product: Product = Product(id: productResponse.id ?? 0,
                                           name: productResponse.name ?? "",
                                           urlImagem: productResponse.urlImagem ?? "",
                                           description: productResponse.description ?? "",
                                           oldPrice: productResponse.oldPrice ?? 0.0,
                                           price: productResponse.price ?? 0.0,
                                           category: category)
            
           
 
            
            productList.append(product)
        }
        
        return productList
        
    }
    
}
