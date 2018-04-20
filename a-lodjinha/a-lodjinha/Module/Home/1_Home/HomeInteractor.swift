
//  HomeInteractor.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//


import UIKit

class HomeInteractor {
    
    private var bannerAPI: BannerAPI
    private var categoryAPI: CategoryAPI
    
    init(bannerAPI: BannerAPI,
         categoryAPI: CategoryAPI) {
        self.bannerAPI = bannerAPI
        self.categoryAPI = categoryAPI
    }
    
    func getBanners(success: @escaping (_ banner: [Banner]) -> (),
                    failure: @escaping (NetworkingError?) -> ()) {
        
        self.bannerAPI.getBanners(success: { (response) in
            
            if let _response = response {
                 let banner = BannerMapper.convertResponseToBannerList(response: _response)
                 success(banner)
            }

            
        }) { (error) in
            failure(error)
        }
        
    }
    
    func getCategory(success: @escaping (_ banner: [Category]) -> (),
                     failure: @escaping (NetworkingError?) -> ()) {
        
        self.categoryAPI.getCategories(success: { (response) in
            
            if let _response = response {
                let category = CategoryMapper.convertResponseToCategoryList(response: _response)
                success(category)
            }
        }) { (error) in
            failure(error)
        }
        
    }
    
    
}
