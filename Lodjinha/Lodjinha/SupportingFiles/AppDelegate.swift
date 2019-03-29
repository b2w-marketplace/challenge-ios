//
//  AppDelegate.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 24/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabbar = LodjinhaTabBarViewController(viewControllers: nil)
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
        return true
    }

}

