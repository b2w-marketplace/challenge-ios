//
//  NetworkingError.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 09/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

class NetworkingError: Error {
    
    enum ErrorType {
        case responseParseError
        
        case unitTestError
        case unknownError
    }
    
    let errorCode: String
    let errorMessage: String
    
    init(errorCode: String, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        
    }
    
    init(errorType: ErrorType) {
        
        /**
         8000 are for API errors
         */
        switch errorType {
        case .responseParseError:
            self.errorCode = "8000"
            self.errorMessage = "Error parsing response JSON"
            
            break
            
        case .unknownError:
            self.errorCode = "-1"
            self.errorMessage = "Unespected error"
            
            break
            
        case .unitTestError:
            self.errorCode = "-3"
            self.errorMessage = "Error used for fake unit tests errors"
            
            break
        }
    }
    
}

