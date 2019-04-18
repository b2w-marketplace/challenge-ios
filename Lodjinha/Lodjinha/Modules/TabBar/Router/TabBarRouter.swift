//
//  TabBarRouter.swift
//  Lodjinha
//
//  Created on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class TabBarRouter: TabBarRouterProtocol, Storyboarded {
    
    var rootRouter: RootRouter?
    static let storyboardName = "TabBar"
    
    weak var viewController: UIViewController!
    
    static func installIntoWindow(rootRouter: RootRouter,
                                  window: UIWindow,
                                  views:[TabBarViewControllerProtocol]) -> TabBarRouterProtocol {
        
        let view = tabBarViewController()
        let presenter = TabBarPresenter()
        let router = TabBarRouter()
        
        view.presenter = presenter
        router.rootRouter = rootRouter
        
        presenter.view = view
        presenter.router = router
        
        var viewControllers = [UIViewController]()
        for view in views {
            let tabBarItem = UITabBarItem()
            tabBarItem.image = view.tabNormalIcon
            tabBarItem.selectedImage = view.tabSelectedIcon
            tabBarItem.title = view.tabTitle
            let viewController = view.configuredViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem = tabBarItem
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.tabBarController?.tabBar.isHidden = false
            viewControllers.append(navigationController)
        }
        
        //installing tabBarController into window
        let tabBarController = view as UITabBarController
        tabBarController.viewControllers = viewControllers
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        window.rootViewController = navigationController
        
        return router
    }
    
    static func tabBarViewController() -> TabBarViewController {
        return storyboard.instantiateViewController()
    }

}
