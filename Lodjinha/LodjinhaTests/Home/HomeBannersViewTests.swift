//
//  HomeBannersViewTests.swift
//  LodjinhaTests
//
//  Created by Douglas da Silva Santos on 25/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import XCTest
@testable import Lodjinha

class HomeBannersViewTests: XCTestCase {

    var sut: HomeBannersView!
    
    func test_BannersViewUpdateBannersWithBannersData_UpdateBannersCount() {
        sut = HomeBannersView(frame: CGRect.zero)
        sut.updateBanners(banners: ["Banner1", "Banner2", "Banner3"])
        XCTAssertTrue(sut.bannersCount > 0)
    }
    
}
