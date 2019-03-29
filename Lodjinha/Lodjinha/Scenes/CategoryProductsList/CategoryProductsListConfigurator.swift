//
//  CategoryProductsListConfigurator.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol CategoryProductsListConfiguratorProtocol {
    func configure(viewController: CategoryProductsListViewController)
}

class CategoryProductsListConfigurator: CategoryProductsListConfiguratorProtocol {
    
    let category: ProductCategory
    
    init(category: ProductCategory) {
        self.category = category
    }
    func configure(viewController: CategoryProductsListViewController) {
        viewController.title = category.description
        
        let categoryProductsServiceGateway = CategoryProductsService(api: ApiServiceClient(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main))
        
        let router = CategoriesRouter(categoriesViewController: viewController)
        let viewModel = CategoryProductsListViewModel(service: categoryProductsServiceGateway, category: category, router: router)
        
        viewModel.categoryProductsListServicesDelegate = viewController
        viewController.viewModel = viewModel
    }
    
}
