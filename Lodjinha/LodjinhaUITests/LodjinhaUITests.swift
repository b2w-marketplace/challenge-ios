//
//  LodjinhaUITests.swift
//  LodjinhaUITests
//
//  Created by Guilherme Antunes on 11/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import XCTest

class LodjinhaUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        let bookButton = app/*@START_MENU_TOKEN@*/.buttons["BookProductButton"]/*[[".buttons[\"Reservar\"]",".buttons[\"BookProductButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        app.tables.cells["ProductCell"].firstMatch.tap()
        XCTAssert(bookButton.exists)
        
        bookButton.tap()
        let alert = app.alerts["Produto reservado com sucesso"]
        XCTAssert(alert.exists)
        
        alert.buttons["OK"].tap()
        XCTAssertFalse(alert.exists)
    }
    
}
