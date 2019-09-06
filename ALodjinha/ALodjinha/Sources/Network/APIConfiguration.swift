//
//  APIConfiguration.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

enum EndpointType: String {
    case banner = "/banner"
    case bestSeller = "/produto/maisvendidos"
    case product = "/produto?"
    case category = "/categoria"
}

class APIConfiguration {
    
    private let basePath = "https://alodjinha.herokuapp.com"
    
    func searchUrl(id: Int? = nil, offset: Int? = nil, endpoint: EndpointType) -> URL {
        switch endpoint {
        case .banner:
            return URL(string: "\(basePath)\(endpoint.rawValue)")!
        case .bestSeller:
            return URL(string: "\(basePath)\(endpoint.rawValue)")!
        case .product:
            return URL(string: "\(basePath)\(endpoint.rawValue)offset=\(offset ?? 0)&categoriaId=\(id ?? 0)")!
        case .category:
            return URL(string: "\(basePath)\(endpoint.rawValue)")!
        }
    }
}
