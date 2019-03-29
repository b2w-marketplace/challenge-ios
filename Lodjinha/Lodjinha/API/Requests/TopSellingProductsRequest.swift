//
//  TopSellingProductsRequest.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct TopSellingProductsRequest: ApiRequest {
    var urlRequest: URLRequest {
        let url = URL(string: "\(baseUrl)/produto/maisvendidos")!
        var request = URLRequest(url: url)
        request.timeoutInterval = timeout
        return request
    }
}
