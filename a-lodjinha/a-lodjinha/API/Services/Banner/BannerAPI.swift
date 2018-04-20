//
//  TwitchAPI.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 29/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

class BannerAPI {
    
    var networking: AbstractNetworking
    
    init(networking: AbstractNetworking) {
        self.networking = networking
    }
    
    func getBanners( success: @escaping (_ responseObject: BannerResponse?) -> (),
                     failure: @escaping (NetworkingError?) -> ()) {
        
        let bannerRequest: BannerRequest = BannerRequest()
        bannerRequest.url = ConstantsService.EndPoint.Lodjinha_Banner
        
        return self.networking.doGet(requestObject: bannerRequest, success: success, failure: failure)
        
    }
    
}
