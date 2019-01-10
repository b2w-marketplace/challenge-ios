//
//  LodjinhaViewController.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class LodjinhaTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = UIColor.WhiteTwo

        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.WarmPurple], for:.selected)

        UITabBar.appearance().tintColor = .WarmPurple

        guard let items = tabBar.items else {
            fatalError("No tabs")
        }

        let inactiveImages = [#imageLiteral(resourceName: "homeInactive"), #imageLiteral(resourceName: "tagInactive")]
        let activeImages = [#imageLiteral(resourceName: "homeActive"), #imageLiteral(resourceName: "tagActive")]
        let titles = [Constants.Home, Constants.About]

        for (index, item) in items.enumerated() {
            item.image = inactiveImages[index].resized(23, nil)
            item.selectedImage = activeImages[index].resized(25, nil)
            item.title = titles[index]
        }
    }
}
