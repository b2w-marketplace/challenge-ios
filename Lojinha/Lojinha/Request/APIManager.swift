//
//  APIManager.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - Banner Manager
class BannerManager: NSObject
{
    static func getBanners(withURL url: String, completion: @escaping(ListBanner?, Error?) -> Void)
    {
        Request.getFrom(url) { (result) in
            if let data = result as? Data
            {
                let banners = ListBanner(dataJSON: JSON(data))
                completion(banners, nil)
            }
            else if let error = result as? Error
            {
                completion(nil, error)
            }
            else
            {
                completion(nil, ErrorManager.error(type: .unknown))
            }
        }
    }
}


// MARK: - Category Manager
class CategoryManager: NSObject
{
    static func getCategory(withURL url: String, completion: @escaping(ListCategory?, Error?) -> Void)
    {
        Request.getFrom(url) { (result) in
            if let data = result as? Data
            {
                let categories = ListCategory(dataJSON: JSON(data))
                completion(categories, nil)
            }
            else if let error = result as? Error
            {
                completion(nil, error)
            }
            else
            {
                completion(nil, ErrorManager.error(type: .unknown))
            }
        }
    }
}


// MARK: - Product Manager
class ProductManager: NSObject
{
    static func getProduct(withURL url: String, completion: @escaping(Product?, Error?) -> Void)
    {
        Request.getFrom(url) { (result) in
            if let data = result as? Data
            {
                let product = Product(dataJSON: JSON(data))
                completion(product, nil)
            }
            else if let error = result as? Error
            {
                completion(nil, error)
            }
            else
            {
                completion(nil, ErrorManager.error(type: .unknown))
            }
        }
    }
    
    
    static func getProducts(withURL url: String, completion: @escaping(ListProduct?, Error?) -> Void)
    {
        Request.getFrom(url) { (result) in
            if let data = result as? Data
            {
                let products = ListProduct(dataJSON: JSON(data))
                completion(products, nil)
            }
            else if let error = result as? Error
            {
                completion(nil, error)
            }
            else
            {
                completion(nil, ErrorManager.error(type: .unknown))
            }
        }
    }
    
    static func postProduct(withURL url: String, completion: @escaping(StatusReserve?, Error?) -> Void)
    {
        Request.postTo(url) { (result) in
            if let data = result as? Data
            {
                let statusReserve = StatusReserve(dataJSON: JSON(data))
                completion(statusReserve, nil)
            }
            else if let error = result as? Error
            {
                completion(nil, error)
            }
            else
            {
                completion(nil, ErrorManager.error(type: .unknown))
            }
        }
    }
}
