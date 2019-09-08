//
//  ExtensionsTest.swift
//  ALodjinhaTests
//
//  Created by Luis Ferreira on 07/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import XCTest
@testable import ALodjinha

class ExtensionsTest: XCTestCase {

    func testShouldFormatValue() {
        let value = Double().formatTwoDecimal(value: 23.0090900)
        XCTAssertEqual(value, "23.01")
    }
}
