//
//  AbstractNetworking.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 09/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

/**
 A default 'abstract' class to any ReactiveX Networking class
 */
class AbstractNetworking {
    
    /**
     Responsible for get HTTP requests with block. Request and Response must conform to AbstractRequest and AbstractResponse
     */
    func doGet<P: AbstractRequest, R: AbstractResponse>(requestObject: P,
                                                                       success: @escaping (_ responseObject: R?) -> ()?,
                                                                       failure: @escaping (NetworkingError?) -> ()) {
        fatalError()
    }
    
    /**
     Responsible for post HTTP requests with block. Request and Response must conform to AbstractRequest and AbstractResponse
     */
    func doPost<P: AbstractRequest, R: AbstractResponse>(requestObject: P,
                                                                        success: @escaping (_ responseObject: R?) -> ()?,
                                                                        failure: @escaping (NetworkingError?) -> ()) {
        fatalError()
    }
}
