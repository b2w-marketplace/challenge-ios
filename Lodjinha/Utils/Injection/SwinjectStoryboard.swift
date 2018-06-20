//
//  SwinjectStoryboard.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Foundation
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    @objc class func setup() {
        
        defaultContainer.register(APIClient.self, factory: { (r) -> APIClient in
            return APIClient.init()
        }).inObjectScope(.container)
        
        defaultContainer.register(ProductReserveManager.self) { (r) -> ProductReserveManager in
            let m = ProductReserveManager.init()
            m.client = r.resolve(APIClient.self)
            return m
        }.inObjectScope(.container)
        
        defaultContainer.storyboardInitCompleted(HomeViewController.self) { (r, c) in
            c.client = r.resolve(APIClient.self)
        }
        
        defaultContainer.storyboardInitCompleted(CategoryViewController.self) { (r, c) in
            c.client = r.resolve(APIClient.self)
        }
        
        defaultContainer.storyboardInitCompleted(ProductDetailViewController.self) { (r, c) in
            c.client = r.resolve(APIClient.self)
            c.reserveManager = r.resolve(ProductReserveManager.self)
        }
        
        defaultContainer.storyboardInitCompleted(AboutViewController.self) { (r, c) in }
        
        //silence SDK warnings
        
        defaultContainer.storyboardInitCompleted(BaseViewController.self) { (r, c) in }
        defaultContainer.storyboardInitCompleted(BaseTabController.self) { (r, c) in }
        defaultContainer.storyboardInitCompleted(BaseNavigationController.self) { (r, c) in }
        defaultContainer.storyboardInitCompleted(UIViewController.self) { (r, c) in }
        defaultContainer.storyboardInitCompleted(UITabBarController.self) { (r, c) in }
        defaultContainer.storyboardInitCompleted(UINavigationController.self) { (r, c) in }
        
    }
    
}
