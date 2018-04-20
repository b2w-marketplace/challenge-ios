//
//  ProductRouter.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class ProductRouter: AbstractRouter {
    
    /**
     It creates all VIPER modules and inject necessary dependencies
     */
    override class func tableViewController() -> ProductTableViewController {

        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductTableViewController") as! ProductTableViewController
       
        let r = ProductRouter(rootViewController: vc)
        let i = ProductInteractor(productAPI: APIInjector.inject(ProductAPI.self))
        let p = ProductPresenter(interactor: i, router: r)
        
        vc.presenter = p
        
        return vc
    }
    
    func goToDetails(product: Product) {
        
        let vc = DetailRouter.viewController()
        vc.product = product
        self.rootViewController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
