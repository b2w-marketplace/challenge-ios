//
//  BannersNetworkGatewayMock.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

@testable import desafiob2w
class BannersNetworkGatewayMock: BannersGateway {

    var onError: Bool = false
    private let banner = Banner(urlImagem: URL.init(string: "www.americanas.com.br")!, linkUrl: URL.init(string: "www.americanas.com.br")!)

    func banners(url: String, completionHandler: @escaping ((Result<[Banner], NetworkError>) -> Void)) {
        if onError {
            completionHandler(Result.fail(NetworkError.weakConnection))
        } else {
            completionHandler(Result.success([banner, banner, banner]))
        }
    }


}
