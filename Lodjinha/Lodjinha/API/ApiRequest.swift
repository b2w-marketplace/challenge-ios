//
//  ApiRequest.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol ApiRequest {
    var baseUrl: String { get }
    var urlRequest: URLRequest { get }
}

extension ApiRequest {
    
    var baseUrl: String {
        return "https://alodjinha.herokuapp.com"
    }
    
}
