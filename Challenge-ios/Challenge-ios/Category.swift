//
//  Category.swift
//  Challenge-ios
//
//  Created by Roberto Luiz Veiga Junior on 17/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Category {
    
    private let serverUrl = Urls.server.rawValue
    private let categoryUrl = Urls.category.rawValue
    
    var id: Int!
    var image: String!
    var description: String!
    
    func getAll(onCompletion:@escaping ([Category])->()) {
        var categories = [Category]()
        Alamofire.request(serverUrl+categoryUrl).responseJSON {
            let categoryList = JSON($0.result.value!)
            if let resData = categoryList["data"].arrayObject {
                let list = resData as! [[String:AnyObject]]
                for items in list {
                    let category = Category()
                    for (key, value) in items {
                        switch (key) {
                        case "id":
                            category.id = value as! Int
                        case "urlImagem":
                            category.image = value as! String
                        case "descricao":
                            category.description = value as! String
                        default: break
                        }
                    }
                    categories.append(category)
                }
                DispatchQueue.main.async( execute: {
                    onCompletion(categories)
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
