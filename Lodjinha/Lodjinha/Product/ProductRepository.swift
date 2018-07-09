//
//  ProductRepository.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation

class Reservation:Codable{
    var  result:String
}

class ProductRepository:Repository{
    internal var api:NetworkManager = RestManager.get(Routes.banner.endpoint)
    
    func makeReservation(itemId:String, completionHandler:@escaping (Bool) -> Void){
      api = RestManager.post(Routes.produtoPorId(id: itemId).endpoint)
    
        api.response { (result:ResultHelper<Reservation>) in
            switch result{
            case .error(let error):
                print(error)
                
                completionHandler(false)
            case .success(let statusCode, let status):
                print(statusCode)
                let isValid = status.result.contains("success") ? true : false
                completionHandler(isValid)

               
            }
        }
        
    }


}
