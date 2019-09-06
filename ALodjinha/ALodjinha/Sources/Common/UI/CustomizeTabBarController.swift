//
//  CustomizeTabBarController.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class CustomizeTabBarController: UITabBarController {
    
    private let mainCoordinator = MainCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = UIColor(red: 115.0/255.0,
                                        green: 0.0/255.0,
                                        blue: 230.0/255.0,
                                        alpha: 1.0)
        self.tabBar.barStyle = .default
        
        mainCoordinator.navigationController.tabBarItem.title = "Home"
        
        viewControllers = [mainCoordinator.navigationController]
    }
}
