//
//  BannerAPI.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class BannerAPI: BaseAPI {
    
    static let shared = BannerAPI()
    
    func getBanners(handler: @escaping ([BannerModel]) -> Void) {
        
        Alamofire.request("\(baseUrl)/banner", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            guard let json = response.result.value as? [String: Any] else { return handler([]) }
            guard let data = json["data"] as? [[String: Any]] else { return handler([]) }
            let bannerArray = Mapper<BannerModel>().mapArray(JSONArray: data)
            
            handler(bannerArray)
            
        }
    }

}
