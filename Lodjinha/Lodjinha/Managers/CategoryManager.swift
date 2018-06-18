//
//  CategoryManager.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 14/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import Foundation

final class CategoryManager: APIManager {
    static func getCategories(success: @escaping([Category]) -> Void, failure: @escaping(NSError) -> Void) {
        let endpoint = Constants.URLs.categories
        
        self.GET(endpoint: endpoint, parameters: nil, success: { (json) in
            let categoryResponse = GeneralResponse(type: .category, dataJSON: json)
            success(categoryResponse.categories!)
        }) { (error) in
            failure(error)
        }
    }
}
