//
//  ProducListRouter.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class ProducListRouter: ProducListRouterProtocol, Storyboarded {
    
    static let storyboardName = "ProducList"
    
    weak var viewController: UIViewController!
    
    static func assembleModule(category: Category) -> UIViewController {
        let view: ProducListViewController = storyboard.instantiateViewController()
        let presenter = ProducListPresenter(category: category)
        let router = ProducListRouter()
        let remoteDataManager = ProducListRemoteDataManager()
        let repository = ProducListRepository(remoteDataManager: remoteDataManager)
        let interactor = ProducListInteractor(repository: repository)
        
        view.presenter = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        return view
    }
    
    func presentProductDetailScreen(product: Product) {
        let productDetailRouterViewController = ProductDetailRouter.assembleModule(product: product)
        viewController.navigationController?.pushViewController(productDetailRouterViewController, animated: true)
    }

}
