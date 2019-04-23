//
//  ProductDetailRouter.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class ProductDetailRouter: ProductDetailRouterProtocol, Storyboarded {
    
    static let storyboardName = "ProductDetail"
    
    weak var viewController: UIViewController!
    
    static func assembleModule(product: Product) -> UIViewController {
        let view: ProductDetailViewController = storyboard.instantiateViewController()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
        let remoteDataManager = ProductDetailRemoteDataManager()
        let interactor = ProductDetailInteractor(product: product, remoteDataManager: remoteDataManager)
        
        view.presenter = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        return view
    }
    
    func presentPreviousScreen() {
        viewController.navigationController?.popViewController(animated: true)
    }

}
