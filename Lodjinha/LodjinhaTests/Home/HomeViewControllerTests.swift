//
//  HomeViewControllerTests.swift
//  LodjinhaTests
//
//  Created by Douglas da Silva Santos on 24/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import XCTest
@testable import Lodjinha

class HomeViewControllerTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

class HomeConfiguratorMock: HomeConfiguratorProtocol {
    
    func configure(viewController: HomeViewController) {
        
    }
}
