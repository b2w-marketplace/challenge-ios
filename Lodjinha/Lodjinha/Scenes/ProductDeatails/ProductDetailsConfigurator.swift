//
//  ProductDetailsConfigurator.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol ProductsDetailsConfiguratorProtocol {
    func configure(viewController: ProductDetailsViewController)
}

class ProductsDetailsConfigurator: ProductsDetailsConfiguratorProtocol {
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    func configure(viewController: ProductDetailsViewController) {
        viewController.title = product.category.description
        
        let productDetailsServiceGateway = ProductDetailsService(api: ApiServiceClient(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main))
        
        let viewModel = ProductDetailsViewModel(service: productDetailsServiceGateway, product: product)
        viewModel.productDetailsServicesDelegate = viewController
        viewController.viewModel = viewModel
    }
    
}
