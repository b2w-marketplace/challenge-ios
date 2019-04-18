//
//  BannerServiceProtocol.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RSReactiveRequest
import RxSwift

protocol BannerServiceProtocol: class {
    
    func fetchBannes(scheduler: ImmediateSchedulerType?) -> Single<BannerDataDecodable>
    
}
