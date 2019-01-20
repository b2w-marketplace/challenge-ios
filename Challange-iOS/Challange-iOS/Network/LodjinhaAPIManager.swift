//
//  LodjinhaAPIManager.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import enum Result.Result

typealias ErrorBlock = ((String?) -> Void)

private func JSONResponseDataFormatter(data: Data) -> Data {
    
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
    
}


struct LodjinhaAPIManager {
    
    static let shared = LodjinhaAPIManager()
    static let provider = MoyaProvider<LodjinhaAPI>(plugins: [
        NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)
        ])
}

extension LodjinhaAPIManager {
    
    fileprivate func request<T: Decodable>(_ target: LodjinhaAPI, type: T.Type, failure: ErrorBlock?, completion: ((T?) -> Void)?) {
        
        LodjinhaAPIManager.provider.request(target) { (result) in
            if self.handleResult(result: result, failure: failure) {
                do {
                    let value = try result.value?.map(type)
                    completion?(value)
                } catch {
                    failure?(nil)
                }
            }
        }
    }
    
    private func handleResult(result: Result<Moya.Response, MoyaError>, failure: ErrorBlock?) -> Bool {
        
        switch result {
        case let .success(response):
            if response.responseClass == .success { return true }
            do {
                let errorModel = try response.map(ErrorModel.self)
                if let message = errorModel.mensagem {
                    failure?(message)
                }
            } catch {
               failure?(nil) 
            }
            
        case let .failure(error):
            guard let error = error as? CustomStringConvertible else {
                failure?(nil)
                return false
            }
            
            var errorString: String? = error.description
            if errorString?.lowercased().contains("moyaerror") ?? false {
                errorString = nil
            }
            
            failure?(errorString)
            
        }
        
        return false
    }
    
}

protocol LodjinhaAPICalls {
    
    func banners(failure: @escaping ErrorBlock, completion: @escaping (BannerModel?) -> Void)
}

extension LodjinhaAPIManager: LodjinhaAPICalls {
    
    func banners(failure: @escaping ErrorBlock, completion: @escaping (BannerModel?) -> Void) {
        request(.banner, type: BannerModel.self, failure: failure, completion: completion)
    }

}

public enum ResponseClass {
    case informational
    case success
    case redirection
    case clientError
    case serverError
    case undefined
    
    public init(statusCode: Int) {
        switch statusCode {
        case 100 ..< 200:
            self = .informational
        case 200 ..< 300:
            self = .success
        case 300 ..< 400:
            self = .redirection
        case 400 ..< 500:
            self = .clientError
        case 500 ..< 600:
            self = .serverError
        default:
            self = .undefined
        }
    }
}

public extension Response {
    
    public var responseClass: ResponseClass {
        return ResponseClass(statusCode: self.statusCode)
    }
    
}
