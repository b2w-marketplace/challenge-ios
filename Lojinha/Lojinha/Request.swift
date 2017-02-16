//
//  Request.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import Alamofire

class Request
{
    // MARK: - Request POST
    static func post(url: String, param: Parameters, completion: @escaping (_ result: Data)->()) {
        Alamofire.request(url, method: .post, parameters: param).responseJSON { response in
            if let data = response.data {
                completion(data)
            }
        }
    }
    
    static func get(url: String, completion: @escaping (_ result: Data)->()) {
        Alamofire.request(url).responseJSON { response in
            if let data = response.data {
                completion(data)
            }
        }
    }
    
    static func getWithParameters(url: String, parameters: [String : AnyObject], completion: @escaping (_ result: Data)->()) {
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            if let data = response.data {
                completion(data)
            }
        }
    }
    
    static func getImage(url: String, completion: @escaping (_ result: Data)->()) {
        Alamofire.request(url).responseData { response in
            if let data = response.result.value {
                completion(data)
            }
        }
    }

}
