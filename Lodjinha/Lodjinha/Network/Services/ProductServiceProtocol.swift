//
//  ProductServiceProtocol.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RSReactiveRequest
import RxSwift

protocol ProductServiceProtocol: class {
    
    func fetchProducts(productEncodable: ProductEncodable, scheduler: ImmediateSchedulerType?) -> Single<ProductDataDecodable>
    func fetchTopSellingProducts(scheduler: ImmediateSchedulerType?) -> Single<ProductDataDecodable>
    func fetchProductDetail(productId: Int, scheduler: ImmediateSchedulerType?) -> Single<ProductDecodable>
    
}
