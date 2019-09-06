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
        return viewController
    }()
    
    lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController(rootViewController: self.homeView)
        return navigation
    }()
    
    var rootViewController: UIViewController {
        return navigationController
    }
}
