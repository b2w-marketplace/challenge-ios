//
//  LodjinhaAPI.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import Moya

enum LodjinhaAPI {
    
    case category
    case banner
    case products
    case mostSold
    case product(productID: Int)
    case saveProduct(productID: Int)
    
}

extension LodjinhaAPI : TargetType {
    
    var baseURL: URL {
        return URL(string: Config.Server.url)!
    }
    
    var path: String {
        switch self {
        case .category:
            return "categoria"
        case .banner:
            return "banner"
        case .products:
            return "produto"
        case .mostSold:
            return "produto/maisvendidos"
        case .product(let productID), .saveProduct(let productID):
            return "produto/\(productID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .saveProduct(let produtcID):
            return .post
        default:
            return .get
            
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        let headers: [String : String] = [
            "Content-Type": "application/json"
        ]
        
        return headers
    }
    
}
