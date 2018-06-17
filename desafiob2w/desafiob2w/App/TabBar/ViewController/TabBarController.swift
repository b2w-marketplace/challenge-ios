//
//  TabBarController.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let homeViewController = HomeViewControllerFactory.make()
        homeViewController.tabBarItem = UITabBarItem(title: R.string.tabBarItem.home(), image: R.image.homeIcon(), tag: 0)
        
        let aboutViewController = AboutViewControllerFactory.make()
        aboutViewController.tabBarItem = UITabBarItem(title: R.string.tabBarItem.about(), image: R.image.tagIcon(), tag: 1)
    
        viewControllers = [homeViewController, aboutViewController]
        tabBar.tintColor = R.color.purleApp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Erro")
    }

}
