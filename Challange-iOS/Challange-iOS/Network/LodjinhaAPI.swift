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
    case productsByCategory(offset: Int, categoryID: Int)
    case product(productID: Int)
    case saveProduct(productID: Int)
    
}

extension LodjinhaAPI : TargetType {
    
    var baseURL: URL {
        switch self {
        case .productsByCategory(let offset, let categoryID):
            return URL(string: Config.Server.url+"produto?offset=\(offset)&limit=20&categoriaId=\(categoryID)")!
        default:
            return URL(string: Config.Server.url)!
        }
        
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
        case .productsByCategory:
            return ""
        case .product(let productID), .saveProduct(let productID):
            return "produto/\(productID)"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .saveProduct:
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
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .productsByCategory:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }

    var headers: [String : String]? {
        let headers: [String : String] = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
}
