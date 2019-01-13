//
//  B2W_API_iOSTests.swift
//  B2W-iOSTests
//
//  Created by Renato Machado Filho on 12/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import XCTest

@testable import B2W_iOS

class B2W_API_iOSTests: XCTestCase {

    var service: APIService!
    
    override func setUp() {
        super.setUp()
        service = APIService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testGetBanners() {
        let promisse = expectation(description: "Status code: 200")
        service.getBanner { (result) in
            switch result {
            case .success:
                promisse.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetCategories() {
        let promisse = expectation(description: "Status code: 200")
        service.getCategories { (result) in
            switch result {
            case .success:
                promisse.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetBestSellers() {
        let promisse = expectation(description: "Status code: 200")
        service.getBestSellers { (result) in
            switch result {
            case .success:
                promisse.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetProductByCategory() {
        let promisse = expectation(description: "Status code: 200")
        service.getProductsByCategory(id: 1, offset: 1) { (result) in
            switch result {
            case .success:
                promisse.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPostReserveProduct() {
        let promisse = expectation(description: "Status code: 200")
        service.postReserveProduct(id: 1) { (result) in
            switch result {
            case .success:
                promisse.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
