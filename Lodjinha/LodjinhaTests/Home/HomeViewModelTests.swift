//
//  HomeViewModelTests.swift
//  LodjinhaTests
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import XCTest
@testable import Lodjinha

class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    
    func test_viewModel_shouldHaveAtLeastOneBannerAfterSuccessLoadingBannersFromAPI() {
        let service = StubSuccessHomeService()
        sut = HomeViewModel(service: service)
        
        sut.loadBanners()
        
        XCTAssertTrue(sut.banners.count > 0)
    }
    
    func test_viewModel_shouldHaveZeroBannersAfterFailingToLoadBannersFromAPI() {
        let service = StubFailureHomeService()
        sut = HomeViewModel(service: service)
        
        sut.loadBanners()
        
        XCTAssertTrue(sut.banners.count == 0)
    }
    
}

class StubSuccessHomeService: HomeServiceGateway {
    
    var banners = [Banner(id: 1, imageUrl: "", linkUrl: "")]
    func loadBanners(completion: @escaping (Result<[Banner]>) -> Void) {
        completion(.success(banners))
    }
}

class StubFailureHomeService: HomeServiceGateway {
    
    let lodjinhaError = NSError(domain: "Banners.Lodjinha", code: 100, userInfo: [NSLocalizedDescriptionKey : "Could not fetch banners from api"])
    func loadBanners(completion: @escaping (Result<[Banner]>) -> Void) {
        completion(.failure(lodjinhaError))
    }
}
