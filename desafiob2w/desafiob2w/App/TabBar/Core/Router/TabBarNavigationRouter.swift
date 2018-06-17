//
//  TabBarNavigationRouter.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

final class TabBarNavigationRouter: TabBarRouter {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    func root() {
        navigationController.navigationBar.barTintColor = .red
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barStyle = .black
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController(rootViewController: TabBarControllerFactory.make())
    }
    
}
