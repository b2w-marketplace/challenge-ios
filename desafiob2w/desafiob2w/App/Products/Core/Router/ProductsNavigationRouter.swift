//
//  ProductsNavigationRouter.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 22/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class ProductsNavigationRouter: ProductsRouter {
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToProductDetail(productId: Int) {
        guard let viewController = R.storyboard.home.productDetailViewController() else { return}
        viewController.loadViewIfNeeded()
        viewController.inject(productId)
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
