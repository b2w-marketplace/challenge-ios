//
//  HomeConfigurator.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol HomeConfiguratorProtocol {
    func configure(viewController: HomeViewController)
}

class HomeConfigurator: HomeConfiguratorProtocol {
    
    func configure(viewController: HomeViewController) {
        viewController.title = "Home"
        let homeServiceGateway = HomeService(api: ApiServiceClient(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main))
        
        let router = HomeRouter(homeViewController: viewController)
        let viewModel = HomeViewModel(service: homeServiceGateway, router: router)
        
        viewModel.homeServicesDelegate = viewController
        viewController.viewModel = viewModel
    }
    
}
