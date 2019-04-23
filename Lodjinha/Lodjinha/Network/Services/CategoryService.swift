//
//  CategoryService.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RSReactiveRequest
import RxSwift

protocol CategoryServiceProtocol: class {
    
    func fetchCategories(scheduler: ImmediateSchedulerType?) -> Single<CategoryDataDecodable>
    
}

final class CategoryService: CategoryServiceProtocol {
    
    private enum API: String, ServiceApi {
        case category = "categoria"
    }
    
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func fetchCategories(scheduler: ImmediateSchedulerType?) -> Single<CategoryDataDecodable> {
        let endpoint = Endpoint(method: .get, api: API.category)
        return requestManager.request(endpoint: endpoint).asSingle()
    }
    
}
