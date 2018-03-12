//
//  LodjinhaTests.swift
//  LodjinhaTests
//
//  Created by Guilherme Antunes on 11/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import XCTest
@testable import Lodjinha

class LodjinhaTests: XCTestCase {
    var controller : ProductDetailsViewController!
    
    override func setUp() {
        super.setUp()
        self.controller = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
        _ = self.controller.view
    }
    
    override func tearDown() {
        self.controller = nil
        super.tearDown()
    }
    
    func testExampleForProductDetailsViewController() {
        let productImageView = self.controller.productImageView
        let productNameLabel = self.controller.productNameLabel
        let description = self.controller.productDetailsTextView
        
        let category = Category()
        let product = Product(category: category, description: "ProductDesc", id: 0, name: "ProductName", oldPrice: 20.0, newPrice: 10.0, imageUrl: "ImageUrl")
        
        self.controller.setSelectedProduct(product)
        self.controller.viewDidLoad()
        
        XCTAssertNotNil(productImageView)
        XCTAssertTrue(productNameLabel?.text == "ProductName")
        XCTAssertFalse(productNameLabel?.text == "Productname")
        XCTAssertTrue(description?.text == "ProductDesc")
        XCTAssertFalse(description?.text == "Productdesc")
    }
    
}
