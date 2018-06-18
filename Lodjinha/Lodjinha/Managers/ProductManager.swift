//
//  RepositoryManager.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 13/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation
import SwiftyJSON

final class ProductManager: APIManager {
    static func getProducts(categoryID: Int?, bestSeller: Bool, success: @escaping([Product]) -> Void, failure: @escaping(NSError) -> Void) {
        var endpoint = Constants.URLs.products
        
        var params = ["":""]
        
        if bestSeller {
            endpoint += Constants.URLs.bestSeller
        }
        else {
            params.updateValue("20", forKey: "offset")
            params.updateValue("1000", forKey: "limit")
            params.updateValue("\(categoryID!)", forKey: "categoriaId")
        }
        
        self.GET(endpoint: endpoint, parameters: params, success: { (json) in
            let productResponse = GeneralResponse(type: .product, dataJSON: json)
            success(productResponse.products!)
        }) { (error) in
            failure(error)
        }
    }
    
    static func reserveProduct(productID: String, success: @escaping() -> Void, failure: @escaping(NSError) -> Void) {
        
        let endpoint = Constants.URLs.products + Constants.URLs.reserveAndProductDetail.replacingOccurrences(of: "{productId}", with: productID)
        
        self.POST(endpoint: endpoint, parameters: nil, success: { (json) in
            if json["message"] == JSON.null {
                success()
            }
            else {
                failure(NSError(domain: "Produto não encontrado.", code: 0, userInfo: nil))
            }
        }) { (error) in
            failure(error)
        }
    }
}
