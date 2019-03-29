//
//  ProductReservationApIRequest.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct ProductReservationApiRequest:ApiRequest {
    
    let productId: Int
    init(productId: Int) {
        self.productId = productId
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: "\(baseUrl)/produto/\(productId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
}
