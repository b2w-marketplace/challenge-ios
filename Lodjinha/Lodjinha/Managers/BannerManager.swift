//
//  BannerManager.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 14/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation

final class BannerManager: APIManager {
    static func getBanners(success: @escaping([Banner]) -> Void, failure: @escaping(NSError) -> Void) {
        let endpoint = Constants.URLs.banners
        
        self.GET(endpoint: endpoint, parameters: nil, success: { (json) in
            let bannerResponse = GeneralResponse(type: .banner, dataJSON: json)
            success(bannerResponse.banners!)
        }) { (error) in
            failure(error)
        }
    }
}
