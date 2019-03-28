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
        
        let homeServiceGateway = HomeService(api: ApiServiceClient(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main))
        let viewModel = HomeViewModel(service: homeServiceGateway)
        viewModel.homeServicesDelegate = viewController
        viewController.viewModel = viewModel
    }
    
}
