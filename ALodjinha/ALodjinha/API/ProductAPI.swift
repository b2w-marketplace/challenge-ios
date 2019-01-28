//
//  ProductAPI.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ProductAPI: BaseAPI {
    
    static let shared = ProductAPI()
    
    func getProducts(page: Int, categoryId: Int, handler: @escaping ([ProductModel]) -> Void) {
        
        let params = ["categoriaId" : categoryId,
                      "limit" : 20,
                      "offset" : page * 20]
        
        Alamofire.request("\(baseUrl)/produto", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            
            guard let json = response.result.value as? [String: Any]  else { return handler([]) }
            guard let data = json["data"] as? [[String: Any]]  else { return handler([]) }
            let productArray = Mapper<ProductModel>().mapArray(JSONArray: data)
            
            handler(productArray)
            
        }
        
    }
    
    func getBestSellers(handler: @escaping ([ProductModel]) -> Void) {
        
        Alamofire.request("\(baseUrl)/produto/maisvendidos", method: .get, parameters:  nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            guard let json = response.result.value as? [String: Any] else { return handler([]) }
            guard let data = json["data"] as? [[String: Any]] else { return handler([]) }
            let productArray = Mapper<ProductModel>().mapArray(JSONArray: data)
            
            handler(productArray)
            
        }
        
    }
    
    func preOrderProduct(productId: Int, handler: @escaping ((success: Bool, message: String)) -> Void) {
        
        Alamofire.request("\(baseUrl)/produto/\(productId)", method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else { return handler((false, "Erro na resposta do servidor")) }
            guard let message = json["data"] as? String else { return handler((true, "")) }
            
            handler((false, message))
        }
        
    }
}
