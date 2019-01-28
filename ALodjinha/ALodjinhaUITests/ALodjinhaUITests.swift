//
//  ALodjinhaUITests.swift
//  ALodjinhaUITests
//
//  Created by Vinicius Andrade on 25/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import XCTest

class ALodjinhaUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBanner() {
        let app = XCUIApplication()
        
        app.scrollViews.otherElements.containing(.pageIndicator, identifier:"page 2 of 3").children(matching: .scrollView).element.tap()
        
        XCTAssertTrue(app.wait(for: .runningBackground, timeout: 20))
    }
    
    func testCategory() {
        
        let app = XCUIApplication()
        sleep(2)
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Livros").element.tap()
        sleep(2)
        app.tables.cells.containing(.staticText, identifier:"HTML e CSS").staticTexts["Por: R$ 19.99"].tap()
        
        XCTAssertTrue(app.staticTexts["HTML e CSS"].exists)
    }
    
    func testProduct() {
        
        let app = XCUIApplication()
        app.scrollViews.otherElements.collectionViews.cells.otherElements.containing(.image, identifier:"placeholder").element.tap()
        sleep(2)
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Game Horizon Zero Down"]/*[[".cells.staticTexts[\"Game Horizon Zero Down\"]",".staticTexts[\"Game Horizon Zero Down\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
        app.buttons["Reservar"].tap()
        
        XCTAssertTrue(app.alerts["Sucesso"].waitForExistence(timeout: 20))
        
    }

}
