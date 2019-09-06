//
//  AppCoordinator.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinatable {
    
    private unowned var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension AppCoordinator {
    func start() {
        let tabBarController = CustomizeTabBarController(nibName: "CustomizeTabBarController", bundle: nil)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
