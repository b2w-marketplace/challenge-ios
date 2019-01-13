//
//  NetworkConstants.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 21/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import UIKit

internal struct NetworkConstants {
    
    struct Network {

        enum HTTPHeaderField: String {
            case authentication = "Authorization"
            case contentType = "Content-Type"
            case acceptType = "Accept"
            case acceptEncoding = "Accept-Encoding"
        }
        
        enum ContentType {
            case json
            case formUrlEncoded
            case formData
            case bearer(String?)
            
            var rawValue: String {
                switch self {
                case .json:
                    return "application/json"
                case .formUrlEncoded:
                    return "application/x-www-form-urlencoded"
                case .formData:
                    return "form-data"
                case .bearer(let token):
                    guard let token = token else {
                        return ""
                    }
                    return "Bearer \(token)"
                }
            }
        }
        
        struct URLs {
            static var base: String {
                get {
                    guard let stringURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
                        fatalError("Set your BASE_URL on info.plist")
                    }
                    return stringURL
                }
            }
        }
    }
}
