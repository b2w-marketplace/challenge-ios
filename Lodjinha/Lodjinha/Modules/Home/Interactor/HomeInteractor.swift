//
//  HomeInteractor.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RxSwift

final class HomeInteractor: HomeInteractorProtocol {
    
    var remoteDataManager: HomeRemoteDataManagerProtocol
    
    init(remoteDataManager: HomeRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
    }
    
    func loadData() -> Completable {
        return remoteDataManager.loadData()
    }
    
    var bannerList: [Banner] {
        return remoteDataManager.bannerList
    }
    
    var numberOfProducts: Int {
        return remoteDataManager.productList.count
    }
    
    var categoryList: [Category] {
        return remoteDataManager.categoryList
    }
    
    func product(at index: Int) -> Product {
        return remoteDataManager.productList[index]
    }
    
}
