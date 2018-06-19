//
//  BannersNetworkGatewayFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct BannersNetworkGatewayFactory {
    static func make() -> BannersGateway {
        return BannersNetworkGateway(getRequest: GetRequestFactory.make())
    }
}
