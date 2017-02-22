//
//  Banner.swift
//  Challenge-ios
//
//  Created by Roberto Luiz Veiga Junior on 16/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Banner {
    
    private let serverUrl = Urls.server.rawValue
    private let bannerUrl = Urls.banner.rawValue
    
    var id: Int!
    var image: String!
    var link: String!
    
    func getAll(onCompletion:@escaping ([Banner])->()) {
        var banners = [Banner]()
        Alamofire.request(serverUrl+bannerUrl).responseJSON {
            let bannerList = JSON($0.result.value!)
            if let resData = bannerList["data"].arrayObject {
                let list = resData as! [[String:AnyObject]]
                for items in list {
                    let banner = Banner()
                    for (key, value) in items {
                        switch (key) {
                        case "id":
                            banner.id = value as! Int
                        case "urlImagem":
                            banner.image = value as! String
                        case "linkUrl":
                            banner.link = value as! String
                        default: break
                        }
                    }
                    banners.append(banner)
                }
                DispatchQueue.main.async( execute: {
                    onCompletion(banners)
                })
            }
        }
    }
    
    class func downloadImage(url: String, onCompletion:@escaping (UIImage)->()) {
        DispatchQueue.main.async {
            Alamofire.request(url)
                .responseData { response in
                    if let data = response.result.value {
                        onCompletion(UIImage(data: data)!)
                    }
            }
        }
    }
}
