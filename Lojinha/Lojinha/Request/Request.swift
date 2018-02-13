//
//  Request.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Request: NSObject
{
    static func getFrom(_ url: String, _ parameters: Dictionary<String, Any>? = nil, headers: [String:String]? = nil ,  completion: @escaping(Any?) -> Void)
    {
        Alamofire.request(url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                print("GET: \(response.request?.url?.absoluteString ?? "")")
                
                switch response.result
                {
                case .success:
                    completion(response.data)
                    break
                    
                case .failure(let error):
                    completion(error)
                    break
                }
        }
    }
    
    static func postTo(_ url: String, parameters: Dictionary<String, Any>?, header: [String:String]? = nil, completion: @escaping(Any?) -> Void)
    {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate()
            .response { (response) in
                print("POST: \(response.request?.url?.absoluteString ?? "")")
                
                if let data = response.data
                {
                    completion(data)
                }
                
                if let error = response.error
                {
                    completion(error)
                }
        }
    }
}
