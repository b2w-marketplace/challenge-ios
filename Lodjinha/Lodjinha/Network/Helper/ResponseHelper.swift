//
//  ResponseHelper.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation

enum ErrorAPI:Error{
    case jsonError
    case invalidData
}
class ResponseHelper{
    private var request:URLRequest
    
    init(request:URLRequest) {
        self.request = request
    }
    
    func getData<T:Decodable>(completion:@escaping (ResultHelper<T>) -> Void){
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                let result = ResultHelper<T>.error(error)
                DispatchQueue.main.async {
                    completion(result)
                }
                return
            }
            
            guard let data = data else{
                let result = ResultHelper<T>.error(ErrorAPI.invalidData)
                DispatchQueue.main.async {
                    completion(result)
                    
                }
                return
            }

            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                let response = response as! HTTPURLResponse
                let result = ResultHelper<T>.success(response.statusCode, obj)
                DispatchQueue.main.async {
                    completion(result)
                }

                
            }catch let errorJSON{
                print("Failed to decode json,", errorJSON)
                DispatchQueue.main.async {
                    let result = ResultHelper<T>.error(ErrorAPI.jsonError)

                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
            }
          
            
        }
        
        task.resume()
    }
    
   
}
