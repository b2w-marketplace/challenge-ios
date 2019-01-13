//
//  LodjinhaRequests.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation
import Alamofire

enum LodjinhaRequests: RequestableInterface {
    case getBanners
    case getProductCategories
    case getBestSellers
    case getProductByCategory(id: Int, offset: Int)
    case postReserveProduct(id: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getBanners,
             .getProductCategories,
             .getBestSellers,
             .getProductByCategory:
            return .get
        case .postReserveProduct:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getBanners:
            return "/banner"
        case .getProductCategories:
            return "/categoria"
        case .getBestSellers:
            return "/produto/maisvendidos"
        case .getProductByCategory(let id, let offset):
            return "/produto?categoriaId=\(id)&offset=\(offset)"
        case .postReserveProduct(let id):
            return "/produto/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getBanners,
             .getProductCategories,
             .getBestSellers,
             .getProductByCategory,
             .postReserveProduct:
            return nil
        }
    }
    
    func error(forStatusCode code: Int) -> ServiceError {
        switch code {
        case 503:
            return ServiceError(type: .serviceUnavailable)
        case 500:
            return ServiceError(type: .serverError)
        case -1009:
            return ServiceError(type: .noInternet)
        default:
            return ServiceError(type: .unknown)
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: NetworkConstants.Network.URLs.base + path) else {
            throw AFError.invalidURL(url: self as! URLConvertible)
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = ServiceHeader.header
        urlRequest.timeoutInterval = 10

        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
