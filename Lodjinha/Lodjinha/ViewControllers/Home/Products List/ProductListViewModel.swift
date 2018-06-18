//
//  ProductListViewModel.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 15/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit

class ProductListViewModel: NSObject {
    func getProductsFromCategory(category: Category, success: @escaping([Product]) -> Void, failure: @escaping(NSError) -> Void) {
        ProductManager.getProducts(categoryID: category.id, bestSeller: false, success: { (products) in
            success(products)
        }) { (error) in
            failure(error)
        }
    }
}
