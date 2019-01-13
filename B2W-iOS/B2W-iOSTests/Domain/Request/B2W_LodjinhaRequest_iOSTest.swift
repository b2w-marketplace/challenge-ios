//
//  B2W_LodjinhaRequest_iOSTest.swift
//  B2W-iOSTests
//
//  Created by Renato Machado Filho on 12/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import XCTest

@testable import B2W_iOS

class B2W_LodjinhaRequest_iOSTest: XCTestCase {

    var request: LodjinhaRequests!
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        request = nil
        super.tearDown()
    }

    func testBannerRequest() {
        request = .getBanners
        
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.path, "/banner")
        XCTAssertNil(request.parameters)
        XCTAssertNoThrow(try request.asURLRequest())
    }
    
    func testProductCategoriesRequest() {
        request = .getProductCategories
        
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.path, "/categoria")
        XCTAssertNil(request.parameters)
        XCTAssertNoThrow(try request.asURLRequest())
    }
    
    func testBestSellersRequest() {
        request = .getBestSellers
        
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.path, "/produto/maisvendidos")
        XCTAssertNil(request.parameters)
        XCTAssertNoThrow(try request.asURLRequest())
    }
    
    func testProductByCategoryRequest() {
        let id = 1
        let offset = 1
        request = .getProductByCategory(id: id, offset: offset)
        
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.path, "/produto?categoriaId=\(id)&offset=\(offset)")
        XCTAssertNil(request.parameters)
        XCTAssertNoThrow(try request.asURLRequest())
    }
    
    func testReserveProductRequest() {
        let id = 1
        request = .postReserveProduct(id: id)
        
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.path, "/produto/\(id)")
        XCTAssertNil(request.parameters)
        XCTAssertNoThrow(try request.asURLRequest())
    }
    
    func testServiceError() {
        request = .getBanners
        
        if case ServiceError.ErrorType.serviceUnavailable = request.error(forStatusCode: 503).type {
            XCTAssert(true, "Service Unavailable: 503")
        } else {
            XCTAssert(false, "Service Unavailable: 503")
        }
        
        if case ServiceError.ErrorType.serverError = request.error(forStatusCode: 500).type {
            XCTAssert(true, "Server Error: 500")
        } else {
            XCTAssert(false, "Server Error: 500")
        }
        
        if case ServiceError.ErrorType.noInternet = request.error(forStatusCode: -1009).type {
            XCTAssert(true, "No Internet: -1009")
        } else {
            XCTAssert(false, "No Internet: -1009")
        }
        
        if case ServiceError.ErrorType.unknown = request.error(forStatusCode: 0).type {
            XCTAssert(true, "unknown: 0")
        } else {
            XCTAssert(false, "unknown: 0")
        }
    }
}
