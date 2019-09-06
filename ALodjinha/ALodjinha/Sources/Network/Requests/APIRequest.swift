//
//  APIRequest.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

class APIRequest {
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type" : "Application/json"]
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 10.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private let session: URLSession = URLSession(configuration: configuration)
    
    func bannerRequest(callback: @escaping (BannerResponse?) -> Void) {
        session.dataTask(with: APIConfiguration().searchUrl(endpoint: .banner)) { (data, response, error) in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                do {
                    let banner = try JSONDecoder().decode(BannerResponse.self, from: data)
                    callback(banner)
                    return
                } catch {
                    print(error.localizedDescription)
                    callback(nil)
                    return
                }
            } else {
                print("Banner Status code: \(response.statusCode)")
            }
        }.resume()
    }
    
    func categoriesRequest(callback: @escaping (CategoriesResponse?) -> Void) {
        session.dataTask(with: APIConfiguration().searchUrl(endpoint: .category)) { (data, response, error) in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                do {
                    let category = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                    callback(category)
                    return
                } catch {
                    print(error.localizedDescription)
                    callback(nil)
                    return
                }
            } else {
                print("Categories Status code: \(response.statusCode)")
            }
        }.resume()
    }
    
    func bestSellerRequest(callback: @escaping (BestSellerResponse?) -> Void) {
        session.dataTask(with: APIConfiguration().searchUrl(endpoint: .bestSeller)) { (data, response, error) in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                do {
                    let bestSeller = try JSONDecoder().decode(BestSellerResponse.self, from: data)
                    callback(bestSeller)
                    return
                } catch {
                    print(error.localizedDescription)
                    callback(nil)
                    return
                }
            } else {
                print("Best Seller Status code: \(response.statusCode)")
            }
        }.resume()
    }
    
    func productRequest(id: Int, offset: Int, callback: @escaping (ProductResponse?) -> Void) {
        session.dataTask(with: APIConfiguration().searchUrl(id: id, offset: offset, endpoint: .product)) { (data, response, error) in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                do {
                    let product = try JSONDecoder().decode(ProductResponse.self, from: data)
                    callback(product)
                    return
                } catch {
                    print(error.localizedDescription)
                    callback(nil)
                    return
                }
            } else {
                print("Product Status code: \(response.statusCode)")
            }
        }.resume()
    }
}
