//
//  MainCoordinator.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class MainCoordinator: NavigationCoordinatable {
    
    private lazy var homeView: HomeView = {
        let viewController = HomeView(nibName: HomeString.HomeView, bundle: nil)
        viewController.delegate = self
        return viewController
    }()
    
    lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController(rootViewController: self.homeView)
        return navigation
    }()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private func showProducts(category: Category) {
        let viewController = ProductView(nibName: ProductViewString.ProductView, bundle: nil)
        viewController.setup(category: category)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showDetail(product: Product) {
        let viewController = DetailView(nibName: DetailString.DetailView, bundle: nil)
        viewController.setup(product: product)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: HomeViewDelegate {
    func fetchProduct(product: Product) {
        showDetail(product: product)
    }
    
    func displayProduct(category: Category) {
        showProducts(category: category)
    }
}
