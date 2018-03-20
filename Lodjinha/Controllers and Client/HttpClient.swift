//
//  Response.swift
//  Lodjinha
//
//  Created by Daniel Novio on 18/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

import Alamofire

class HttpClient: NSObject {
    
    static let instance = HttpClient()
    
    func doGET(withPath path: String!, parameters: Parameters?, sucessBlock success: @escaping (_ response: Any) -> Void, failureBlock failure: @escaping (_ errorMessage: String) -> Void) {
        guard let path = path else {
            NSLog("Fatal Error, no path in a GET method")
            
            return
        }
        let configuration = Configuration()
        
        let url = URL(string: configuration.baseURL + path)
        
        Alamofire.request(url!, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: configuration.headers).validate().responseJSON { (response) in
            if response.result.isSuccess {
                guard let JSON = response.result.value else {
                    NSLog("Request is finished but didn't found any data on it!")
                    
                    failure("Ocorreu um problema, tente novamente mais tarde")
                    
                    return
                }
                success(JSON)
                
            } else {
                self.errorHandling(withResult: response.result)

                failure("Ocorreu um problema, tente novamente mais tarde")
            }
        }
    }
    
    func doPOST(withPath path: String!, parameters: Parameters?, sucessBlock success: @escaping (_ response: Any) -> Void, failureBlock failure: @escaping (_ errorMessage: String) -> Void) {
        guard let path = path else {
            NSLog("Fatal Error, no path in a GET method")
            
            return
        }
        let configuration = Configuration()
        
        let url = URL(string: configuration.baseURL + path)
        
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: configuration.headers).validate().responseJSON { (response) in
            if response.result.isSuccess {
                guard let JSON = response.result.value else {
                    NSLog("Request is finished but didn't found any data on it!")
                    
                    failure("Ocorreu um problema, tente novamente mais tarde")
                    
                    return
                }
                success(JSON)
                
            } else {
                self.errorHandling(withResult: response.result)
                
                failure("Ocorreu um problema, tente novamente mais tarde")
            }
        }
    }
    
    func errorHandling(withResult result: Result<Any>) {
        guard case let .failure(error) = result else {
            return
        }
        
        if let error = error as? AFError {
            switch error {
                
            case .invalidURL(let url):
                print("Invalid URL: \(url) - \(error.localizedDescription)")
                
            case .parameterEncodingFailed(let reason):
                print("Parameter encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                
            case .multipartEncodingFailed(let reason):
                print("Multipart encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                
            case .responseValidationFailed(let reason):
                print("Response validation failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                
                switch reason {
                    
                case .dataFileNil, .dataFileReadFailed:
                    print("Downloaded file could not be read")
                    
                case .missingContentType(let acceptableContentTypes):
                    print("Content Type Missing: \(acceptableContentTypes)")
                    
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    
                case .unacceptableStatusCode(let code):
                    print("Response status code was unacceptable: \(code)")
                }
                
            case .responseSerializationFailed(let reason):
                print("Response serialization failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            }
            
            print("Underlying error: \(error.underlyingError)")
            
        } else if let error = error as? URLError {
            print("URLError occurred: \(error)")
            
        } else {
            print("Unknown error: \(error)")
        }
    }
}
