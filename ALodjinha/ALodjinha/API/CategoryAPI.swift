//
//  CategoryAPI.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class CategoryAPI: BaseAPI {
    
    static let shared = CategoryAPI()
    
    func getCategories(handler: @escaping ([CategoryModel]) -> Void) {
        
        Alamofire.request("\(baseUrl)/categoria", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            guard let json = response.result.value as? [String: Any] else { return handler([]) }
            guard let data = json["data"] as? [[String: Any]] else { return handler([]) }
            let categoryArray = Mapper<CategoryModel>().mapArray(JSONArray: data)
            
            handler(categoryArray)
            
        }
    }
    
}
