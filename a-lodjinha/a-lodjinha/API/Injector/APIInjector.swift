//
//  APIInjector.swift
//
//  Created by Daniel Rocha on 3/29/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

class APIInjector {
    
    private static var injection: [String : AnyObject] = [:]
    
    static func initialize() {
        /*
         Services injection
         */
        
        let networking: AbstractNetworking = AlamofireNetworking()
        self.injection[String(describing: AbstractNetworking.self)] = networking
        
        let bannerAPI: BannerAPI = BannerAPI(networking: networking)
        self.injection[String(describing: BannerAPI.self)] = bannerAPI
        
        let categoryAPI: CategoryAPI = CategoryAPI(networking: networking)
        self.injection[String(describing: CategoryAPI.self)] = categoryAPI
        
        let productAPI: ProductAPI = ProductAPI(networking: networking)
        self.injection[String(describing: ProductAPI.self)] = productAPI
        
        
    }
    
    static func inject<T>(_ classType: AnyClass) -> T {
        return self.injection[String(describing: classType)] as! T
    }
    
}
