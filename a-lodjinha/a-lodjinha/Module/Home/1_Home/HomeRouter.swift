
//
//  HomeRouter.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class HomeRouter: AbstractRouter {
    
    /**
     It creates all VIPER modules and inject necessary dependencies
     */
    override class func viewController(vc: UIViewController) -> UIViewController {
        
        guard let vc = vc as? HomeViewController else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            return vc
        }
        
        let r = HomeRouter(rootViewController: vc)
        let i = HomeInteractor(bannerAPI: APIInjector.inject(BannerAPI.self),
                               categoryAPI:  APIInjector.inject(CategoryAPI.self))
        let p = HomePresenter(interactor: i, router: r)
        
        vc.presenter = p

        return vc
    }

    func goToProductList(categoryID: Int,
                         categoryName: String)  {
        
        let vc = ProductRouter.tableViewController()
        vc.modeList = .product
        vc.categoryID = categoryID
        vc.categoryName = categoryName
        self.rootViewController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func goToDetails(product: Product) {
        
        let vc = DetailRouter.viewController()
        vc.product = product
        self.rootViewController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
