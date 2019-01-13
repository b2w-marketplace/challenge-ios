//
//  B2W_iOSUITests.swift
//  B2W-iOSUITests
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import XCTest
@testable import B2W_iOS

class B2W_iOSUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testHomeViewControllerSwipes() {
        app.launch()
        
        let table = getHomeTableView()
        table.swipeDown()
        table.swipeUp()
        table.swipeDown()
        
        let cell = table.cells.matching(identifier: "BannerTableViewCell0").firstMatch
        XCTAssert(cell.exists, "Should exist Banner cell")
        
        if !cell.visible() {
            table.scrollToElement(element: cell)
            sleep(1)
        }
        
        cell.swipeLeft()
        cell.swipeRight()
        
        let cell2 = table.cells.matching(identifier: "CategoryTableViewCell0").firstMatch
        XCTAssert(cell2.exists, "Should exist Category cell")
        
        if !cell2.visible() {
            table.scrollToElement(element: cell2)
            sleep(1)
        }
        
        cell2.swipeLeft()
        cell2.swipeRight()
    }
    
    func testReserveProductFlow() {
        app.launch()
        
        let table = getHomeTableView()
        
        let cell = table.cells["ProductListTableViewCell0"]
        XCTAssertTrue(cell.exists, "Should exist best sellers cells")
        
        if !cell.visible() {
            table.scrollToElement(element: cell)
            sleep(1)
        }
        
        cell.tap()
        sleep(1)
        
        XCTAssertTrue(app.isDisplayProductViewController)
        
        interactWithReserveAlert()
        
        sleep(1)
        XCTAssertTrue(app.isDisplayHomeViewController, "Should go back to HomeViewController")
    }
    
    func testReserveProductByCategoryFlow() {
        app.launch()
        
        let table = getHomeTableView()
        
        let cell = table.cells["CategoryTableViewCell0"]
        XCTAssertTrue(cell.exists, "Should exist categories cells")
        
        if !cell.visible() {
            table.scrollToElement(element: cell)
            sleep(1)
        }
        
        cell.tap()
        sleep(1)
        
        XCTAssertTrue(app.isDisplayCategoryViewController)
        
        let cell2 = app.cells["ProductListTableViewCell0"]
        XCTAssertTrue(cell2.exists, "Should exist products cell")
        
        cell2.tap()
        sleep(1)
        
        XCTAssertTrue(app.isDisplayProductViewController)
        
        interactWithReserveAlert()
        
        sleep(1)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.isDisplayHomeViewController, "Should go back to HomeViewController")
    }

    private func interactWithReserveAlert() {
        let btn = app.buttons.matching(identifier: "ProductViewController.ReserveBtn").firstMatch
        XCTAssert(btn.exists)
        btn.tap()
        
        let alert = app.alerts.element(boundBy: 0)
        XCTAssert(alert.exists, "Should present Alert to confirm the reservation")
        alert.buttons.matching(identifier: "Alert.Ok").firstMatch.tap()
    }
    
    private func getHomeTableView() -> XCUIElement {
        XCTAssertTrue(app.isDisplayHomeViewController)
        
        let table = app.tables["HomeTableView"]
        wait(for: table.cells.element, timeout: 10)
        sleep(1)
        return table
    }
}
