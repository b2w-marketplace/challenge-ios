//
//  B2W_NetworkConstants_iOSTests.swift
//  B2W-iOSTests
//
//  Created by Renato Machado Filho on 12/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import XCTest
@testable import B2W_iOS

class B2W_NetworkConstants_iOSTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBaseUrl() {
        #if DEBUG
            XCTAssertEqual(NetworkConstants.Network.URLs.base, "https://alodjinha.herokuapp.com", "The base URL should be https://alodjinha.herokuapp.com")
        #else
            XCTAssertEqual(NetworkConstants.Network.URLs.base, "https://alodjinha.herokuapp.com", "The base URL should be https://alodjinha.herokuapp.com")
        #endif
    }
    
    func testContentTypes() {
        XCTAssertEqual(NetworkConstants.Network.ContentType.json.rawValue, "application/json")
        XCTAssertEqual(NetworkConstants.Network.ContentType.formUrlEncoded.rawValue, "application/x-www-form-urlencoded")
        XCTAssertEqual(NetworkConstants.Network.ContentType.formData.rawValue, "form-data")
        XCTAssertTrue(NetworkConstants.Network.ContentType.bearer("").rawValue.contains("Bearer"))
        
    }
    
    func testHTTPHeaderFields() {
        XCTAssertEqual(NetworkConstants.Network.HTTPHeaderField.authentication.rawValue, "Authorization")
        XCTAssertEqual(NetworkConstants.Network.HTTPHeaderField.contentType.rawValue, "Content-Type")
        XCTAssertEqual(NetworkConstants.Network.HTTPHeaderField.acceptType.rawValue, "Accept")
        XCTAssertEqual(NetworkConstants.Network.HTTPHeaderField.acceptEncoding.rawValue, "Accept-Encoding")
        
    }
}
