//
//  BannersNetworkGateway.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

class BannersNetworkGateway: BannersGateway {
    
    private let getRequest: GetRequestable
    init(getRequest: GetRequestable) {
        self.getRequest = getRequest
    }
    
    func banners(url: String, completionHandler: @escaping ((Result<[Banner], NetworkError>) -> Void)) {
        getRequest.get(url: url) { (data, error) in
            let result = GenerateResultObjectToArray<BannersCodable, Banner>(self.converterBanners).generate(data, error)
            completionHandler(result)
        }
    }
    
    private func converterBanners(entity: BannersCodable) -> [Banner] {
        return entity.data.map({
            Banner.init(urlImagem: $0.urlImagem, linkUrl: $0.linkUrl)
        })
    }
}
