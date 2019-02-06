//
//  ProductClient.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class ProductClient: NSObject {
    //MARK: - Best Seller List
    
    func getBestSellerProducts(successHandler: @escaping (_ responseObject: Array<Product>?) -> (), errorHandler: @escaping (_ errorObject: NSError?, _ isCancelled: Bool) -> ()) -> URLSessionTask
    {
        let url = "produto/maisvendidos"
        let parameters: [String: String] = [:]
        
        let request = ApiClient().createRequest(url, method: .get, parameters: parameters)
        return ApiClient().executeWithHandler(request, successHandler: { data in
            successHandler(ProductClient.parseProductList(data: data as! NSDictionary))
        }, errorHandler: errorHandler)
    }
    
    //MARK: - Parse Product List
    
    class func parseProductList(data: NSDictionary) -> Array<Product>?{
        var productList = [Product]()
        
        let arrayProduct: NSArray = data.object(forKey: "data") as! NSArray
        
        for value in arrayProduct{
            productList.append(Product.init(data: value as! NSDictionary))
        }
        
        return productList
    }
}
