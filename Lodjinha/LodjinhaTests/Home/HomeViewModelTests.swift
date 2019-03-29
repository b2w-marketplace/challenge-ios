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
        sut = HomeViewModel(service: service, router: HomeRouterSpy())

        sut.loadHome()
        
        XCTAssertTrue(sut.banners.count > 0)
    }
    
    func test_viewModel_shouldHaveZeroBannersAfterFailingToLoadBannersFromAPI() {
        let service = StubFailureHomeService()
        sut = HomeViewModel(service: service, router: HomeRouterSpy())
        
        sut.loadHome()
        
        XCTAssertTrue(sut.banners.count == 0)
    }
    
}

class HomeRouterSpy: HomeRouterProtocol {
    func presentCategoryProducts(forCategory category: ProductCategory) {
        
    }
    
    func presentProductDetails(forProduct product: Product) {
        
    }
    
}

class StubSuccessHomeService: HomeServiceGateway {
    func loadCategories(completion: @escaping (Result<[ProductCategory]>) -> Void) {
        
    }
    
    func loadTopSellingProducts(completion: @escaping (Result<[Product]>) -> Void) {
        
    }
    
    
    var banners = [Banner(id: 1, imageUrl: "", linkUrl: "")]
    func loadBanners(completion: @escaping (Result<[Banner]>) -> Void) {
        completion(.success(banners))
    }
}

class StubFailureHomeService: HomeServiceGateway {
    func loadCategories(completion: @escaping (Result<[ProductCategory]>) -> Void) {
        
    }
    
    func loadTopSellingProducts(completion: @escaping (Result<[Product]>) -> Void) {
        
    }
    
    
    let lodjinhaError = NSError(domain: "Banners.Lodjinha", code: 100, userInfo: [NSLocalizedDescriptionKey : "Could not fetch banners from api"])
    func loadBanners(completion: @escaping (Result<[Banner]>) -> Void) {
        completion(.failure(lodjinhaError))
    }
}
