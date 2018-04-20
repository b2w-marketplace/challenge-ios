//
//  DetailRouter.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/20/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class DetailRouter: AbstractRouter {
    
    /**
     It creates all VIPER modules and inject necessary dependencies
     */
    override class func viewController() -> DetailViewController {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let r = DetailRouter(rootViewController: vc)
        let p = DetailPresenter(router: r)
        
        vc.presenter = p
        
        return vc
    }
    
    
}
