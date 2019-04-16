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
    
}
