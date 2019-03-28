//
//  LodjinhaTabBarViewController.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class LodjinhaTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let defaultControllers: [UIViewController] = {
        let configurator = HomeConfigurator()
        let homeVC = HomeViewController()
        homeVC.configurator = configurator
        let home = UINavigationController(rootViewController: homeVC)
        home.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        
        let about = AboutViewController()
        about.tabBarItem = UITabBarItem(title: "Sobre", image: nil, selectedImage: nil)
        
        return [home, about]
    }()
    
    convenience init() {
        self.init(viewControllers: nil)
    }
    
    init(viewControllers: [UIViewController]?) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers ?? defaultControllers
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.isTranslucent = false
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
