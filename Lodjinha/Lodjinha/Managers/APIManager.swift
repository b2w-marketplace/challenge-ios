//
//  APIManager.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 13/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager: NSObject {
    // MARK: - Lets and Vars
    static var header : HTTPHeaders = ["content-type" : "application/json;charset=UTF-8",
                                       "connection": "keep-alive",
                                       "server": "Cowboy",
                                       "transfer-encoding": "Identity",
                                       "via": "1.1 vegur"]
    
    
    private static func request(method: HTTPMethod, endpoint: String, parameters: [String: Any]?, success: @escaping(JSON) -> Void, failure: @escaping(NSError) -> Void) {
        
        switch Reach().connectionStatus() {
        case .offline:
            failure(NSError(domain: "Sem conexão com a internet.", code: 0, userInfo: nil))
            return
        case .unknown:
            failure(NSError(domain: "Erro desconhecido.", code: 500, userInfo: nil))
            return
        default:
            break
        }
    
        
        let url = URL(string: Constants.URLs.baseURL + endpoint)!
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: self.header)
            .responseJSON(completionHandler: { (response) in
                switch (response.result) {
                case .success:
                    do {
                        let json = try JSON(data: response.data!)
                        if response.response?.statusCode == 200 {
                            success(json)
                        }
                        else {
                            let error = NSError(domain: "Erro - \((response.response?.statusCode)!).", code:response.response?.statusCode ?? 0, userInfo: nil)
                            failure(error)
                        }
                        
                    }
                    catch {
                        let error = NSError(domain: "Erro de serialização do JSON.", code:response.response?.statusCode ?? 0, userInfo: nil)
                        failure(error)
                    }
                case .failure:
                    let error = NSError(domain: "Erro desconhecido.", code:response.response?.statusCode ?? 0, userInfo: nil)
                    failure(error)
                }
            })
    }
    
    // MARK: - Requests
    static func GET (endpoint: String, parameters: [String: Any]?, success: @escaping(JSON) -> Void, failure: @escaping(NSError) -> Void) {
        self.request(method: .get, endpoint: endpoint, parameters: parameters, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    static func POST(endpoint: String, parameters: [String: Any]?, success: @escaping(JSON) -> Void, failure: @escaping(NSError) -> Void) {
        self.request(method: .post, endpoint: endpoint, parameters: parameters, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
}
