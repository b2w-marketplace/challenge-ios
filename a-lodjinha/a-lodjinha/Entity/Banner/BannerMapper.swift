//
//  BannerMapper.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

class BannerMapper {
    
    static func convertResponseToBannerList(response: BannerResponse) -> [Banner] {
        
        guard let data = response.data else {
            return []
        }
        
        var bannerList: [Banner] = []
        
        for banner in data {
            
            let banner: Banner = Banner(id: banner.id ?? 0,
                                        linkUrl: banner.linkUrl ?? "",
                                        urlImagem: banner.urlImagem ?? "")
         
            bannerList.append(banner)
        }
        
        return bannerList
        
    }
    
}
