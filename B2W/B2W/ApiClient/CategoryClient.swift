//
//  CategoryClient.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class CategoryClient: NSObject {
    //MARK: - Category List
    
    func getBanner(successHandler: @escaping (_ responseObject: Array<Category>?) -> (), errorHandler: @escaping (_ errorObject: NSError?, _ isCancelled: Bool) -> ()) -> URLSessionTask
    {
        let url = "categoria"
        let parameters: [String: String] = [:]
        
        let request = ApiClient().createRequest(url, method: .get, parameters: parameters)
        return ApiClient().executeWithHandler(request, successHandler: { data in
            successHandler(CategoryClient.parseCategoryList(data: data as! NSDictionary))
        }, errorHandler: errorHandler)
    }
    
    //MARK: - Parse Category List
    
    class func parseCategoryList(data: NSDictionary) -> Array<Category>?{
        var categoryList = [Category]()
        
        let arrayCategory: NSArray = data.object(forKey: "data") as! NSArray
        
        for value in arrayCategory{
            categoryList.append(Category.init(data: value as! NSDictionary))
        }
        
        return categoryList
    }
}
