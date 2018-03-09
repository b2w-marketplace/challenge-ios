//
//  BannerApiProvider.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 21/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation
import Alamofire

class BannerApiProvider {
    
    static func fetchBanners(url : URL, completion : @escaping BannerCallback) {
        
        Alamofire.request(url).validate().responseData { (response) in
            guard let data = response.data else {
                print("Failed to get data!")
                return
            }
            
            guard let banners = try? JSONDecoder().decode([Banner].self, from: data) else {
                print("Failed to parse banners!")
                return
            }
            
            completion { banners }
            
        }

    }
    
}
