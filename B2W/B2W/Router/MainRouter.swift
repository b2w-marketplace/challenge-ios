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
    
    //MARK: - Show Products by Category
    
    func showProductsByCategory(category: Category){
        let categoryPresenter = CategoryPresenter()
        categoryPresenter.category = category
        categoryPresenter.registerDelegate()
        
        if let navigation = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigation.pushViewController(categoryPresenter.productList, animated: true)
        }
    }
    
    //MARK: - Show Products Detail
    
    func showProductDetail(product: Product){
        let productDetailPresenter = ProductDetailPresenter()
        productDetailPresenter.product = product
        productDetailPresenter.registerDelegate()
        
        if let navigation = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigation.pushViewController(productDetailPresenter.productDetail, animated: true)
        }
    }
}
