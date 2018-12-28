//
//  AppDelegate.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 26/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController(rootViewController: MainViewController())
        navigationController.navigationBar.barTintColor = .mainColor
        navigationController.navigationBar.isOpaque = true
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

