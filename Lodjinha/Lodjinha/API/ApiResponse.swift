//
//  ApiResponse.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation


struct ApiResponse<T: Decodable> {
    
    var data: Data?
    var httpUrlResponse: HTTPURLResponse?
    var entity: T?
    
    init(data: Data?, httpResponse: HTTPURLResponse?) throws {
        self.data = data
        self.httpUrlResponse = httpResponse
        do {
            self.entity = try parseEntity()
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: self.httpUrlResponse, data: self.data)
        }
        
    }
    
    func parseEntity() throws -> T {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: self.data!)
        return decoded
    }
}
