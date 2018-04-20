//
//  AlamofireNetworking.swift
//
//  Created by Daniel Sousa on 09/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/**
 Networking implementation using Alamofire
 */
class AlamofireNetworking: AbstractNetworking {
    
    /**
     Conforms to AbstractRxNetworking
     */
    override func doGet<P: AbstractRequest, R: AbstractResponse>(requestObject: P,
                                                                 success: @escaping (_ responseObject: R?) -> ()?,
                                                                 failure: @escaping (NetworkingError?) -> ()) {
        
        return self.doRequestWithBlock(requestObject: requestObject,
                                       method: HTTPMethod.get,
                                       success: success,
                                       failure: failure)
    }
    
    /**
     Conforms to AbstractRxNetworking
     */
    override func doPost<P: AbstractRequest, R: AbstractResponse>(requestObject: P,
                                                                  success: @escaping (_ responseObject: R?) -> ()?,
                                                                  failure: @escaping (NetworkingError?) -> ()) {
        
        return self.doRequestWithBlock(requestObject: requestObject,
                                       method: HTTPMethod.post,
                                       success: success,
                                       failure: failure)
    }
    
    /**
     Makes the HTTP request and parses the response with block
     */
    private func doRequestWithBlock<P: AbstractRequest, R: AbstractResponse>(requestObject: P,
                                                                             method: HTTPMethod,
                                                                             success: @escaping (_ responseObject: R?) -> ()?,
                                                                             failure: @escaping (NetworkingError?) -> ()) {
        
        print(requestObject.url)
        
        var paramters: Parameters? = nil
        
        if method != .get {
            paramters = requestObject.toDictionary()
        }
        
        _ = Alamofire.request(requestObject.url, method: method, parameters: paramters, encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { (response: DataResponse<Any>) in
                switch response.result {
                case .success:
                    
                    
                    guard let jsonResponse = response.result.value, let responseObject: R = Mapper<R>().map(JSONObject: jsonResponse) else {
                        let error = NetworkingError(errorCode: "-1", errorMessage: "Response not initialized properly")
                        failure (error)
                        return
                    }
                    
                    
                    success(responseObject)
                    
                    break
                case .failure:
                    if response.error != nil {
                        let error = response.error! as NSError
                        let apiError = NetworkingError(errorCode: "\(error.code)", errorMessage: error.localizedDescription)
                        
                        failure(apiError)
                        
                        print(error.localizedDescription)
                        
                        return
                    }
                    
                    failure(NetworkingError(errorType: .unknownError))
                    
                    break
                }
            })
        
    }
    
    
}
