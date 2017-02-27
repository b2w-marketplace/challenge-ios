//
//  Service.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class Service: NSObject {
    
    static func requestObject<T: Mappable>(with url: String, params: Parameters? = nil, completion: @escaping (_ responseObject: T?, _ errorMessage: String?) -> Void) {
        Alamofire.request(url, parameters: params).responseJSON { response in
            if let error = response.result.error {
                completion(nil, error.localizedDescription)
            } else if let responseObject = (response.result.value as? [String: AnyObject])?["data"] {
                if let object = Mapper<T>().map(JSONObject: responseObject) {
                    completion(object, nil)
                } else {
                    completion(nil, Strings.errorSerialization)
                }
            } else {
                completion(nil, Strings.errorUnexpected)
            }
        }
    }
    
    static func requestArray<T: Mappable>(with url: String, params: Parameters? = nil, completion: @escaping (_ responseObject: [T]?, _ errorMessage: String?) -> Void) {
        Alamofire.request(url, parameters: params).responseJSON { response in
            if let error = response.result.error {
                completion(nil, error.localizedDescription)
            } else if let responseObject = (response.result.value as? [String: AnyObject])?["data"] {
                if let objects = Mapper<T>().mapArray(JSONObject: responseObject) {
                    completion(objects, nil)
                } else {
                    completion(nil, Strings.errorSerialization)
                }
            } else {
                completion(nil, Strings.errorUnexpected)
            }
        }
    }
    
}
