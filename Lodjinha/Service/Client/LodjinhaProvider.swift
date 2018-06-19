//
//  LodjinhaProvider.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Moya

enum LodjinhaProvider {
    case getBanner
    case getCategories
    case getBestSellers
    case getProductsForCategory(categoryId: Int, offset: Int, limit: Int)
    case getProductForId(productId: Int)
    case reserveProductForId(productId: Int)
}

extension LodjinhaProvider: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://alodjinha.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getBanner:
            return "/banner"
        case .getCategories:
            return "/categoria"
        case .getBestSellers:
            return "/produto/maisvendidos"
        case .getProductsForCategory:
            return "/produto"
        case .getProductForId(let productId), .reserveProductForId(let productId):
            return "/produto/\(productId)"
        }
    }
    
    var method: Method {
        switch self {
        case .getBanner, .getCategories, .getBestSellers, .getProductsForCategory, .getProductForId:
            return .get
        case .reserveProductForId:
            return .post
        }
    }
    
    var sampleData: Data {
        //no need for mockup data
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getBanner, .getCategories, .getBestSellers, .getProductForId, .reserveProductForId:
            return .requestPlain
        case .getProductsForCategory(let categoryId, let offset, let limit):
            return .requestParameters(parameters: ["categoriaId": categoryId, "offset": offset, "limit": limit], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
