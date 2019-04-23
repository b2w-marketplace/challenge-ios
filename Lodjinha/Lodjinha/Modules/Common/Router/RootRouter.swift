//
//  RootRouter.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

final class RootRouter: NSObject {
    
    var window: UIWindow!
    var tabBarRouter: TabBarRouterProtocol?
    
    init(window: UIWindow)  {
        super.init()
        self.window = window
    }
    
    func installViewIntoRootViewController() {
        var views = [TabBarViewControllerProtocol]()
        
        // Home
        let homeViewController: HomeRouterProtocol = HomeRouter()
        views.append(homeViewController as! TabBarViewControllerProtocol)
        
        // About
        let aboutViewController: AboutRouterProtocol = AboutRouter()
        views.append(aboutViewController as! TabBarViewControllerProtocol)
        
        self.tabBarRouter = TabBarRouter.installIntoWindow(rootRouter: self,
                                                           window: self.window,
                                                           views: views)
    }
}
