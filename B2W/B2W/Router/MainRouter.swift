//
//  MainRouter.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class MainRouter: NSObject {
    let appDelegate : AppDelegate =  UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - Initial View
    
    func intialView(){
        let tabBarPresenter = TabBarPresenter()
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = UINavigationController(rootViewController: tabBarPresenter.tabBar)
        appDelegate.window?.makeKeyAndVisible()
    }
}
