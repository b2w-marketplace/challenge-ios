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
        home.navigationBar.tintColor = UIColor(red: 99/255, green: 66/255, blue: 140/255, alpha: 1)
        home.navigationBar.barTintColor = UIColor(red: 99/255, green: 66/255, blue: 140/255, alpha: 1)
        home.navigationBar.isTranslucent = false
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeDeselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "homeActive")?.withRenderingMode(.alwaysOriginal))
        
        let about = AboutViewController()
        about.tabBarItem = UITabBarItem(title: "Sobre", image: UIImage(named: "tagDeselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "tagSelected")?.withRenderingMode(.alwaysOriginal))
        
        return [home, about]
    }()
    
    convenience init() {
        self.init(viewControllers: nil)
    }
    
    init(viewControllers: [UIViewController]?) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers ?? defaultControllers
        self.tabBar.barTintColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 99/255, green: 66/255, blue: 140/255, alpha: 1)
        self.tabBar.isTranslucent = false
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
