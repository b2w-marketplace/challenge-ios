//
//  RepositoryResponse.swift
//  GitHubAPI-Swift
//
//  Created by Matheus Fusco on 24/03/18.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeneralResponse: NSObject {
    var products : [Product]?
    var banners : [Banner]?
    var categories : [Category]?
    
    convenience init(type: Constants.Response, dataJSON: JSON) {
        self.init()
        
        if dataJSON["data"].array != nil {
            let contentArray = dataJSON["data"].arrayValue
            
            switch type {
            case .product:
                products = [Product]()
                for prod in contentArray {
                    let model = Product(dataJSON: prod)
                    self.products!.append(model)
                }
                
            case .banner:
                banners = [Banner]()
                for banner in contentArray {
                    let model = Banner(dataJSON: banner)
                    self.banners!.append(model)
                }
                
            case .category:
                categories = [Category]()
                for cat in contentArray {
                    let model = Category(dataJSON: cat)
                    self.categories!.append(model)
                }
            }
        }
    }
}
