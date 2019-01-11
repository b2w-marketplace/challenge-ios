//
//  NetworkService.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkService {
    let baseURL: String

    init(withBaseURL baseURL: String) {
        self.baseURL = baseURL
    }

    func fetch<Model: Codable> (fromRoute route: Route<Model>, productId: Int? = nil, categoryId: Int? = nil,
                                offset: Int? = nil, limit: Int? = nil,
                                then: @escaping (Result<Model>) -> Void) {

        var endpoint = route.endpoint
        if let id = productId { endpoint += "/" + "\(id)"}
        var parameters: Parameters?
        if let `categoryId` = categoryId {
            if parameters == nil {
                parameters = ["categoriaId": categoryId]
            } else {
                parameters!["categoriaId"] = categoryId
            }
        }
        if let `offset` = offset {
            if parameters == nil {
                parameters = ["offset": offset]
            } else {
                parameters!["offset"] = offset
            }
        }
        if let `limit` = limit {
            if parameters == nil {
                parameters = ["limit": limit]
            } else {
                parameters!["limit"] = limit
            }
        }

        guard let url = URL(string: self.baseURL + endpoint ) else {
            then(.failure(NSError(domain: "alodjinha.herokuapp.com", code: 500)))
            return
        }

        Alamofire
            .request(url, parameters: parameters)
            .responseData { (response) in
                guard response.error == nil else {
                    then(.failure(response.error!))
                    return
                }

                let jsonDecoder = JSONDecoder()

                if let data = response.data,
                    let model = try? jsonDecoder.decode(Model.self, from: data) {
                    then(.success(model))
                } else {
                    then(.failure(NSError(  domain: "alodjinha.herokuapp.com",
                                            code: 1000,
                                            userInfo: ["error": "wrong model"])))
                }
        }
    }

    func reserveProduct(productId: Int, then: @escaping (Result<String>) -> Void) {

        let endpoint = "produto/\(productId)"

        guard let url = URL(string: self.baseURL + endpoint ) else {
            then(.failure(NSError(domain: "alodjinha.herokuapp.com", code: 500)))
            return
        }

        Alamofire
            .request(url, method: .post)
            .responseData { (response) in
                guard response.error == nil else {
                    then(.failure(response.error!))
                    return
                }

                let jsonDecoder = JSONDecoder()

                struct Response: Decodable {
                    let result: String
                }

                if let data = response.data,
                    let model = try? jsonDecoder.decode(Response.self, from: data) {
                    then(.success(model.result))
                } else {
                    then(.failure(NSError(  domain: "alodjinha.herokuapp.com",
                                            code: 1000,
                                            userInfo: ["error": "wrong model"])))
                }
        }
    }

}
