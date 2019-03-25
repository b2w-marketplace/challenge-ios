//
//  HomeViewControllerTests.swift
//  LodjinhaTests
//
//  Created by Douglas da Silva Santos on 24/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import XCTest

protocol BannersLoader {
    func load(completion: @escaping (([String]) -> Void))
}

class RemoteBannerLoader: BannersLoader {
    func load(completion: @escaping (([String]) -> Void)) {
        //Api Call
        let banners: [String] = ["Promo1", "Promo2", "Promo3"]
        completion(banners)
    }
}

class HomeViewController: UIViewController {
    
    var bannerLoader: BannersLoader!
    var banners: [String] = []
    
    convenience init(bannerFeedLoader: BannersLoader) {
        self.init()
        self.bannerLoader = bannerFeedLoader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerLoader.load { (banners) in
            self.banners = banners
        }
    }
    
}

class HomeViewControllerTests: XCTestCase {

    func test_homeViewController_shouldShowBanners_afterLoadingView() {
        //Given
        let sut = HomeViewController(bannerFeedLoader: RemoteBannerLoader())
        //When
        sut.loadViewIfNeeded()
        //Then
        XCTAssertTrue(sut.banners.count > 0)
    }
    
}
