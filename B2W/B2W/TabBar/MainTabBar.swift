//
//  MainTabBar.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePresenter = HomePresenter()
        homePresenter.homeView.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(named: "home-icon-deselected"), selectedImage: UIImage(named: "home-icon"))
        
        let aboutPresenter = AboutPresenter()
        aboutPresenter.aboutView.tabBarItem = UITabBarItem(title: "SOBRE", image: UIImage(named: "about-icon-deselected"), selectedImage: UIImage(named: "about-icon"))
        
        let tabBarList = [UINavigationController(rootViewController: homePresenter.homeView), aboutPresenter.aboutView]
        viewControllers = tabBarList
    }
}
