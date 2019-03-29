//
//  CategoryProductsListRouter.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol CategoriesRouterProtocol {
    func presentProductDetails(forProduct product: Product)
}

class CategoriesRouter: CategoriesRouterProtocol {
    
    weak var categoriesViewController: CategoryProductsListViewController?
    
    init(categoriesViewController: CategoryProductsListViewController) {
        self.categoriesViewController = categoriesViewController
    }
    
    func presentProductDetails(forProduct product: Product) {
        let productDetailsVC = ProductDetailsViewController()
        productDetailsVC.hidesBottomBarWhenPushed = true
        productDetailsVC.configurator = ProductsDetailsConfigurator(product: product)
        
        categoriesViewController?.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
}
