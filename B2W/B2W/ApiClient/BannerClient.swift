//
//  BannerClient.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class BannerClient: NSObject {
    
    //MARK: - Banner List
    
    func getBannerList(successHandler: @escaping (_ responseObject: Array<Banner>?) -> (), errorHandler: @escaping (_ errorObject: NSError?, _ isCancelled: Bool) -> ()) -> URLSessionTask
    {
        let url = "banner"
        let parameters: [String: String] = [:]
        
        let request = ApiClient().createRequest(url, method: .get, parameters: parameters)
        return ApiClient().executeWithHandler(request, successHandler: { data in
            successHandler(BannerClient.parseBannerList(data: data as! NSDictionary))
        }, errorHandler: errorHandler)
    }
    
    //MARK: - Parse Banner List
    
    class func parseBannerList(data: NSDictionary) -> Array<Banner>?{
        var bannerList = [Banner]()
        
        let arrayBanner: NSArray = data.object(forKey: "data") as! NSArray
        
        for value in arrayBanner{
            bannerList.append(Banner.init(data: value as! NSDictionary))
        }
        
        return bannerList
    }
}
