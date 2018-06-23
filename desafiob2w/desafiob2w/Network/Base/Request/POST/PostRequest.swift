//
//  PostRequest.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 20/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Alamofire
import UIKit

final class PostRequest: PostRequestable {
    
    func post(url: String, completionHandler: @escaping (Data?, NetworkError?) -> Void) {
        makeRequest(url: url, completionHandler: completionHandler)
    }
    
    private func makeRequest(url urlString: String, completionHandler: @escaping (Data?, NetworkError?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        Alamofire.request(url, method: .post).responseData { (response) in
            if let error = response.error as? URLError {
                if error.code == .notConnectedToInternet {
                    completionHandler(nil, NetworkError.offline)
                    return
                }
                completionHandler(nil, NetworkError.offline)
            } else {
                completionHandler(response.data, nil)
            }
            
        }
        
    }
    
}
