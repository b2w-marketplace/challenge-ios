//
//  CategoriesApiRequest.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct CategoriesApiRequest: ApiRequest {
    
    var urlRequest: URLRequest {
        let url = URL(string: "https://alodjinha.herokuapp.com/categoria")!
        let request = URLRequest(url: url)
        return request
    }
    
}
