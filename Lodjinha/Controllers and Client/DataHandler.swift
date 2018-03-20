//
//  Response.swift
//  Lodjinha
//
//  Created by Daniel Novio on 18/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit
import Alamofire

protocol GenericObjectSerializable {
    init?(fromJSON json: NSDictionary?)
}

class DataHandler: NSObject {

    static let instance = DataHandler()
    
    func getProducts(withCategoryId categoryId: Int?, productOffset: Int?, sucessBlock success: @escaping (_ response: [Product]?) -> Void, failureBlock failure: @escaping (_ message: String) -> Void) {
        
        var path = "produto"
        
        if let productOffset = productOffset {
            path += "?offset=" + String(productOffset)
        }

        if let categoryId = categoryId {
            path += "&categoriaId=" + String(categoryId)
        }
        
        path += "&limit=20"
        
        get(path: path, sucessBlock: { (data) in
            if data is NSArray {
                let products: [Product]? = self.extractGenericObject(fromJSONArray: data as! NSArray)
                
                success(products)
            }
            
        }) { (errorMessage) in
            failure(errorMessage)
        }
    }
    
    func getBanners(sucessBlock success: @escaping (_ response: [Banner]?) -> Void, failureBlock failure: @escaping (_ message: String) -> Void) {
        get(path: "banner", sucessBlock: { (data) in
            if data is NSArray {
                let banners: [Banner]? = self.extractGenericObject(fromJSONArray: data as! NSArray)
                
                success(banners)
            }
            
        }) { (errorMessage) in
            failure(errorMessage)
        }
    }
    
    func getCategories(sucessBlock success: @escaping (_ response: [Category]?) -> Void, failureBlock failure: @escaping (_ message: String) -> Void) {
        get(path: "categoria", sucessBlock: { (data) in
            if data is NSArray {
                let categories: [Category]? = self.extractGenericObject(fromJSONArray: data as! NSArray)
                
                success(categories)
            }
            
        }) { (errorMessage) in
            failure(errorMessage)
        }
    }
    
    func getProduct(with productId: String!, sucessBlock success: @escaping (_ response: Product?) -> Void, failureBlock failure: @escaping (_ message: String) -> Void) {
        get(path: "produto/" + productId, sucessBlock: { (product) in
            if product is Product {
                success(product as? Product)
            }
            
        }) { (errorMessage) in
            failure(errorMessage)
        }
    }
    
    func getMostSelledProducts(sucessBlock success: @escaping (_ response: [Product]?) -> Void, failureBlock failure: @escaping (_ message: String) -> Void) {
        get(path: "produto/maisvendidos", sucessBlock: { (data) in
            if data is NSArray {
                let products: [Product]? = self.extractGenericObject(fromJSONArray: data as! NSArray)
                
                success(products)
            }
            
        }) { (errorMessage) in
            failure(errorMessage)
        }
    }
    
    func postProduct(with productId: Int?, sucessBlock success: @escaping (_ response: String?) -> Void, failureBlock failure: @escaping (_ message: String) -> Void) {
        var path = "produto"
        if let productId = productId {
            path += "/" + String(productId)
        }

        post(path: path, parameters: nil, sucessBlock: { (json) in
            if json != nil {
                success("Reserva confirmada")
            }
        }) { (errorMessage) in
            failure(errorMessage)
        }
    }
}

extension DataHandler {
    func get(path: String, sucessBlock success: @escaping (_ response: Any?) -> Void, failureBlock failure: @escaping (_ message: String) -> Void) {
        HttpClient.instance.doGET(withPath: path, parameters: nil, sucessBlock:{ (response) in
            guard let json = response as? NSDictionary else {
                return
            }
            
            guard let data: NSArray = json["data"] as? NSArray else {
                NSLog("Didnt found data in response")
                
                if let product: Product = Product(fromJSON: json) {
                    success(product)
                }
                
                return
            }
            
            success(data)
            
        } , failureBlock: failure)
    }
    
    func post(path: String, parameters: Parameters?, sucessBlock success: @escaping (_ response: Any?) -> Void, failureBlock failure: @escaping (_ message: String) -> Void) {
        HttpClient.instance.doPOST(withPath: path, parameters: parameters, sucessBlock:{ (response) in
            guard let json = response as? NSDictionary else {
                return
            }
            
            guard let data: NSArray = json["data"] as? NSArray else {
                NSLog("Didnt found data in response")
                
                if let product: Product = Product(fromJSON: json) {
                    success(product)
                }
                
                return
            }
            
            success(data)
            
        } , failureBlock: failure)
    }
    
    func extractGenericObject<T: GenericObjectSerializable>(fromJSONArray json: NSArray) -> [T]? {
        var returnedObjects: [T] = []

        for dict in json {
            if dict is NSDictionary {
                guard let object = T(fromJSON: dict as? NSDictionary) else {
                    return []
                }
                
                returnedObjects.append(object)
            }
        }
        
        return returnedObjects
    }
}

extension GenericObjectSerializable {
    
    func extractObject<T: GenericObjectSerializable>(fromJSONArray json: NSArray) -> [T]? {
        var returnedObjects: [T] = []
        
        for dict in json {
            if dict is NSDictionary {
                guard let object = T(fromJSON: dict as? NSDictionary) else {
                    return []
                }
                
                returnedObjects.append(object)
            }
        }
        
        return returnedObjects
    }
}
