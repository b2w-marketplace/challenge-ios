//
//  File.swift
//  B2W-iOSUITests
//
//  Created by Renato Machado Filho on 12/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//
import XCTest

extension XCUIApplication {
    
    var isDisplayHomeViewController: Bool {
        return otherElements["HomeViewController"].exists
    }
    
    var isDisplayCategoryViewController: Bool {
        return otherElements["CategoryViewController"].exists
    }
    
    var isDisplayProductViewController: Bool {
        return otherElements["ProductViewController"].exists
    }
    
    var isDisplayAboutViewController: Bool {
        return otherElements["AboutViewController"].exists
    }
}

extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}

extension XCTestCase {
    func wait(for element: XCUIElement, timeout: TimeInterval) {
        let p = NSPredicate(format: "exists == true")
        let e = expectation(for: p, evaluatedWith: element, handler: nil)
        wait(for: [e], timeout: timeout)
    }
}
