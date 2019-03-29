//
//  HomeRouter.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol HomeRouterProtocol {
    func presentCategoryProducts(forCategory category: ProductCategory)
    func presentProductDetails(forProduct product: Product)
}

class HomeRouter: HomeRouterProtocol {
    
    weak var homeViewController: HomeViewController?
    
    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }
    
    func presentCategoryProducts(forCategory category: ProductCategory) {
        let categoryProductsVC = CategoryProductsListViewController()
        categoryProductsVC.hidesBottomBarWhenPushed = true
        categoryProductsVC.configurator = CategoryProductsListConfigurator(category: category)
        
        homeViewController?.navigationController?.pushViewController(categoryProductsVC, animated: true)
    }
    
    func presentProductDetails(forProduct product: Product) {
        let productDetailsVC = ProductDetailsViewController()
        productDetailsVC.hidesBottomBarWhenPushed = true
        productDetailsVC.configurator = ProductsDetailsConfigurator(product: product)
        
        homeViewController?.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
}
