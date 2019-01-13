//
//  ServiceEngine.swift
//  
//
//  Created by Renato de Souza Machado Filho on 22/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation
import Alamofire

internal struct ServiceEngine {
    
    static func performRequest<T: DTOInterface>(route: RequestableInterface, completionHandler: @escaping (Result<T>) -> Void) {
        Alamofire.request(route)
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    
                    do {
                        let decoder = JSONDecoder()
                        let parsedObject = try decoder.decode(T.self, from: data)
                        return completionHandler(.success(parsedObject))
                    } catch let error {
                        print(error)
                        completionHandler(.failure(ServiceError(type: .parserError)))
                    }
                case .failure(let error):
                    var friendlyError: ServiceError
                    
                    if let statusCode = response.response?.statusCode {
                        let serveError = route.error(forStatusCode: statusCode)
                        friendlyError = serveError
                    } else {
                        let serverError = route.error(forStatusCode: (error as NSError).code)
                        
                        if serverError != ServiceError(type: .unknown) {
                            friendlyError = serverError
                        } else {
                            completionHandler(.failure(error))
                            return
                        }
                    }
                    
                    completionHandler(.failure(friendlyError))
                }
            })
    }
}
