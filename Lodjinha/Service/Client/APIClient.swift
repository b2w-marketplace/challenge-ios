//
//  APIClient.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class APIClient {
    
    let lodjinhaProvider: MoyaProvider<LodjinhaProvider>
    
    init() {
        lodjinhaProvider = MoyaProvider.init()
    }
}
