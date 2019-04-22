//
//  ProductDetailInteractor.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    private let remoteDataManager: ProductDetailRemoteDataManagerProtocol
    
    init(remoteDataManager: ProductDetailRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
    }
    
}
