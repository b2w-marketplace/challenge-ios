//
//  RequestableInterface.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 20/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Alamofire

internal protocol RequestableInterface: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    func error(forStatusCode code: Int) -> ServiceError
}
