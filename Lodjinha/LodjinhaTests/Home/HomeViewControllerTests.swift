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

    func test_homeViewController_shouldHaveBannersToShow_afterLoadingView() {
        let sut = HomeViewController(homeInfoLoader: RemoteHomeInfoLoader())
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView.tableHeaderView)
        XCTAssertTrue(sut.tableView.tableHeaderView!.isKind(of: HomeBannersView.self))
        let banners = sut.tableView.tableHeaderView as! HomeBannersView
        XCTAssertTrue(banners.bannersCount > 0)
    }
    
    func test_homeViewController_shoulHaveCategoriesToShow_afterLoadingView() {
        let sut = HomeViewController(homeInfoLoader: RemoteHomeInfoLoader())
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.categories.count > 0)
    }
    
    func test_homeViewController_shouldHaveTopSellingProductsToShow_afterLoadingView() {
        let sut = HomeViewController(homeInfoLoader: RemoteHomeInfoLoader())
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.topSellingProducts.count > 0)
    }
 
    func test_homeViewController_shouldHaveTableViewOutletInitialized_afterLoadingView() {
        let sut = HomeViewController(homeInfoLoader: RemoteHomeInfoLoader())
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView)
    }
    
}
