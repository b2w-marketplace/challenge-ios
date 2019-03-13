//
//  APIServices.swift
//  MoyaTest
//
//  Created by Gustavo Azevedo de Oliveira on 09/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import Moya
import SwiftyJSON

enum APIServices {
    case getBanners
    case getCategories
    case getMostSoldProducts
    case getCategoryProducts(categoryId: Int, limit: Int?, offset: Int?)
    case getProduct(productId: Int)
    case reserveProduct(productId: Int)
}

extension APIServices: TargetType {
    var baseURL: URL {
        return URL(string: "https://alodjinha.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getBanners:
            return "/banner"
        case .getCategories:
            return "/categoria"
        case .getMostSoldProducts:
            return "/produto/maisvendidos"
        case .getCategoryProducts(_):
            return "/produto"
        case .getProduct(let productId), .reserveProduct(let productId):
            return "/produto/\(productId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBanners, .getCategories, .getMostSoldProducts, .getCategoryProducts, .getProduct:
            return .get
        case .reserveProduct:
            return .post
        }
    }
    
    var sampleData: Data {
        guard let url = Bundle.main.url(forResource: "returnSample", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let sampleJson = try? JSON(data: data) else {
                return Data()
        }
        
        
        var sampleResult: JSON?
        
        switch self {
        case .getBanners:
            sampleResult = sampleJson[SampleJsonFields.banners.rawValue]
        case .getCategories:
            sampleResult = sampleJson[SampleJsonFields.categories.rawValue]
        case .getMostSoldProducts:
            sampleResult = sampleJson[SampleJsonFields.mostSold.rawValue]
        case .getCategoryProducts:
            sampleResult = sampleJson[SampleJsonFields.productsList.rawValue]
        case .getProduct:
            sampleResult = sampleJson[SampleJsonFields.product.rawValue]
        case .reserveProduct:
            sampleResult = nil
        }
        
        if let convertJson = sampleResult {
            let sampleData = try? convertJson.rawData()
            return sampleData ?? Data()
        }
        else {
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case let .getCategoryProducts(categoryId, limit, offset):
            var params = ["categoriaId": categoryId]
            if let limitParam = limit {
                params["limit"] = limitParam
            }
            if let offsetParam = offset {
                params["offset"] = offsetParam
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }    
}

// MARK: - Sample Json Access Helper
private enum SampleJsonFields: String {
    case banners, categories, productsList, mostSold, product
}
