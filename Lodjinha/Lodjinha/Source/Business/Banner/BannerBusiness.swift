//
//  BannerBusiness.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation

typealias BannerCallback = (@escaping () -> [Banner]?) -> Void

class BannerBusiness {
    
    private var banners : [Banner]?
    
    public func fetchBanners(completion : @escaping BannerCallback) {
        
        guard let url = URL(string: ApiProvider.bannerUrl) else {
            print("Failed to get url!")
            return
        }
        
        BannerApiProvider.fetchBanners(url: url) { (banners) in
            
            self.banners = banners()
            
            completion { self.banners }
            
        }
        
    }
    
}
