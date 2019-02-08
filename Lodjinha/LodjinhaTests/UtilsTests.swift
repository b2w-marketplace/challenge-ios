//
//  UtilsTests.swift
//  LodjinhaTests
//
//  Created by Victor Hideki Rezende Takai on 07/02/19.
//  Copyright © 2019 Kalivos. All rights reserved.
//

import XCTest
@testable import Lodjinha

class UtilsTests: XCTestCase {
    
    func testMoneyFormatter() {
        let valorFormatado = moneyFormatter(12312.4636436)
        XCTAssertNotNil(valorFormatado)
    }
    
    func testMoneyFormatterMinimumIntegerDigits() {
        let valorFormatdo = moneyFormatter(0.00)
        XCTAssertNotEqual(valorFormatdo, ",00")
    }
    
    func testMoneyFormatterMinimumFractionDigits() {
        let valorFormatado = moneyFormatter(5)
        XCTAssertEqual(valorFormatado, "5,00")
    }

    func testMoneyFormatterRounding() {
        let valorFormatado = moneyFormatter(10.33333333333)
        XCTAssertEqual(valorFormatado, "10,33")
    }
    
}

