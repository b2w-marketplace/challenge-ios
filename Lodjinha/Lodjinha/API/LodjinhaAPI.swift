//
//  LodjinhaAPI.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

struct LodjinhaAPI {
    private static let provider = MoyaProvider<APIServices>()
    
    static func getHomeBanners(completion: @escaping (_ banners: [BannerModel]?)->Void) {
        provider.request(.getBanners) { (result) in
            switch result {
            case .success(let response):
                do {
                    let fileteredResponse = try response.filterSuccessfulStatusCodes()
                    let bannersJson = try JSON(data: fileteredResponse.data)
                    
                    let bannersList = bannersJson["data"]
                    let bannersListData = try bannersList.rawData()
                    
                    let banners = try JSONDecoder().decode([BannerModel].self, from: bannersListData)
                    completion(banners)
                }
                catch {
                    print("Status code problem: " + error.localizedDescription)
                    completion(nil)
                }
                
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
