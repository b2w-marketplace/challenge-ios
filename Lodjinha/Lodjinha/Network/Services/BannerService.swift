//
//  BannerService.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RSReactiveRequest
import RxSwift

final class BannerService: BannerServiceProtocol {
    
    private enum API: String, ServiceApi {
        case banner = "banner"
    }
    
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func fetchBannes(scheduler: ImmediateSchedulerType?) -> Single<BannerDataDecodable> {
        let endpoint = Endpoint(method: .get, api: API.banner)
        return requestManager.request(endpoint: endpoint).asSingle()
    }
    
}
