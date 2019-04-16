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
    case category = "/categoria"
    case bestSeller = "/produto/maisvendidos"
    case product = "/produto?categoriaId="
}

class BaseAPI {
    
    private let basePath = "https://alodjinha.herokuapp.com"
    
    func searchURL(id: Int = 0, endpoint: EndpointType) -> URL {
        if id != 0 {
            return URL(string: "\(basePath)\(endpoint.rawValue)\(id)")!
        } else {
            return URL(string: "\(basePath)\(endpoint.rawValue)")!
        }
    }
}
