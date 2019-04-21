//
//  APIRequest.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

class APIRequest {
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.httpMaximumConnectionsPerHost = 5
        config.timeoutIntervalForRequest = 10.0
        return config
    }()
    
    private let session = URLSession(configuration: configuration)
    
    func loadBanner(completion: @escaping (BannerResponse?) -> Void) {
        session.dataTask(with: BaseAPI().searchURL(endpoint: .banner)) { (data, response, error) in
            guard let data = data else {return}
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode == 200 {
                do {
                    let banner = try JSONDecoder().decode(BannerResponse.self, from: data)
                    completion(banner)
                    return
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            } else {
                print("Response Status: \(response.statusCode)")
            }
        }.resume()
    }
    
    func loadBestSeller(completion: @escaping (ProductResponse?) -> Void) {
        session.dataTask(with: BaseAPI().searchURL(endpoint: .bestSeller)) { (data, response, error) in
            guard let data = data else {return}
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode == 200 {
                do {
                    let bestSeller = try JSONDecoder().decode(ProductResponse.self, from: data)
                    completion(bestSeller)
                    return
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            } else {
                print("Response Status: \(response.statusCode)")
            }
        }.resume()
    }
    
    func loadCategory(completion: @escaping (CategoryResponse?) -> Void) {
        session.dataTask(with: BaseAPI().searchURL(endpoint: .category)) { (data, response, error) in
            guard let data = data else {return}
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode == 200 {
                do {
                    let category = try JSONDecoder().decode(CategoryResponse.self, from: data)
                    completion(category)
                    return
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            } else {
                print("Response Status: \(response.statusCode)")
            }
            }.resume()
    }
    
    func loadProduct(id: Int, completion: @escaping (ProductIdResponse?) -> Void) {
        session.dataTask(with: BaseAPI().searchURL(id: id, endpoint: .product)) { (data, response, error) in
            guard let data = data else {return}
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode == 200 {
                do {
                    let product = try JSONDecoder().decode(ProductIdResponse.self, from: data)
                    completion(product)
                    return
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            } else {
                print("Response Status: \(response.statusCode)")
            }
        }.resume()
    }
}
