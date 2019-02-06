//
//  MainTabBar.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let homePresenter = HomePresenter()
        homePresenter.homeView.tabBarItem = UITabBarItem(title: kHome, image: UIImage(named: "home-icon-deselected"), selectedImage: UIImage(named: "home-icon"))
        
        let aboutPresenter = AboutPresenter()
        aboutPresenter.aboutView.tabBarItem = UITabBarItem(title: kAbout, image: UIImage(named: "about-icon-deselected"), selectedImage: UIImage(named: "about-icon"))
        
        let tabBarList = [UINavigationController(rootViewController: homePresenter.homeView), aboutPresenter.aboutView]
        viewControllers = tabBarList
        
        setNavigationHomeImage()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == kHome{
            setNavigationHomeImage()
        }else{
            navigationItem.titleView = nil
            self.navigationItem.title = item.title
        }
    }
    
    func setNavigationHomeImage(){
        navigationItem.titleView = UIImageView.init(image:  UIImage(named: "home-title-image"))
    }
}
