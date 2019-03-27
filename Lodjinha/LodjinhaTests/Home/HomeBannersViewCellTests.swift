//
//  HomeBannersViewCellTests.swift
//  LodjinhaTests
//
//  Created by Douglas da Silva Santos on 26/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import XCTest
@testable import Lodjinha

class HomeBannersViewCellTests: XCTestCase {

    var sut: HomeBannerViewCell!
    
    func test_configureCellWithBanner_setsImageView() {
        sut = HomeBannerViewCell(image: UIImage())
        
        XCTAssertNotNil(sut.imageView.image)
    }
    
}

class HomeBannerViewCell {
    
    var imageView: UIImageView!
    
    init(image: UIImage) {
        imageView = UIImageView(image: image)
    }
    
}
