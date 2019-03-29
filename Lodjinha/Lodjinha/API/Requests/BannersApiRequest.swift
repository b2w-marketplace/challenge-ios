//
//  BannersApiRequest.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct BannersApiRequest: ApiRequest {
    
    var urlRequest: URLRequest {
        let url = URL(string: "\(baseUrl)/banner")!
        let request = URLRequest(url: url)
        return request
    }
}
