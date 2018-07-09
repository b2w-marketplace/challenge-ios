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
        api = RestManager.get(Routes.banner.endpoint)
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
    
    func getCategoryList( completionHandler:@escaping ([Categoria]) -> Void){
        api = RestManager.get(Routes.categoria.endpoint)

        api.response { (result:ResultHelper<DataCategory>) in
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
    
    func getBestSellersList( completionHandler:@escaping ([Produto]) -> Void){
        api = RestManager.get(Routes.produto.endpoint)
        let bestSellerAPI = api.addHeader("maisvendidos", value: "maisvendidos")
        
        bestSellerAPI.response { (result:ResultHelper<DataBestSeller>) in
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
