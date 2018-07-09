//
//  HomeRepository.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation


class HomeRepository{
    private var api:NetworkManager = RestManager.get(Routes.banner.endpoint)
    
    func getBannerList( completionHandler:@escaping ([Banner]) -> Void){
        api.response { (result:ResultHelper<DataBanner>) in
            switch result{
            case .error(let error):
                debugPrint(error)
                completionHandler([])
            case .success(let statusCode, let resultData):
                print(statusCode)
                completionHandler(resultData.data)
            }
        }
        
    }
}
