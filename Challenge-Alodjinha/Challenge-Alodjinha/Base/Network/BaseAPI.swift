//
//  BaseAPI.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

enum EndpointType: String {
    case banner = "/banner"
}

class BaseAPI {
    
    private let basePath = "https://alodjinha.herokuapp.com"
    
    func searchURL(id: Int = 0, endpoint: EndpointType) -> URL {
        if id != 0 {
            return URL(string: "")!
        } else {
            return URL(string: "\(basePath)\(endpoint.rawValue)")!
        }
    }
}
