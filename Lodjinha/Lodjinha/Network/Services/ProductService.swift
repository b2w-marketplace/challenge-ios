//
//  ProductService.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RSReactiveRequest
import RxSwift

final class ProductService: ProductServiceProtocol {
    
    private enum API: String, ServiceApi {
        case product = "produto"
        case topSellingProducts = "produto/maisvendidos"
        case productDetail = "produto/{produtoId}"
    }
    
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func fetchProducts(productEncodable: ProductEncodable, scheduler: ImmediateSchedulerType?) -> Single<ProductDataDecodable> {
        let endpoint = Endpoint(method: .get, api: API.product)
        return requestManager.request(endpoint: endpoint, data: productEncodable).asSingle()
    }
    
    func fetchTopSellingProducts(scheduler: ImmediateSchedulerType?) -> Single<ProductDataDecodable> {
        let endpoint = Endpoint(method: .get, api: API.topSellingProducts)
        return requestManager.request(endpoint: endpoint).asSingle()
    }
    
    func fetchProductDetail(productId: Int, scheduler: ImmediateSchedulerType?) -> Single<ProductDecodable> {
        let endpoint = Endpoint(method: .get, api: API.productDetail, resource: String(describing: productId))
        return requestManager.request(endpoint: endpoint).asSingle()
    }
    
}
