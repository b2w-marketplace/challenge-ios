//
//  HomeViewControllerTests.swift
//  LodjinhaTests
//
//  Created by Douglas da Silva Santos on 24/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import XCTest

protocol HomeInfoLoader {
    func loadBanners(completion: @escaping (([String]) -> Void))
    func loadCategories(completion: @escaping (([String]) -> Void))
    func loadTopSellingProducts(completion: @escaping (([String]) -> Void))
}

class RemoteHomeInfoLoader: HomeInfoLoader {
    func loadBanners(completion: @escaping (([String]) -> Void)) {
        //Api Call
        let banners: [String] = ["Promo1", "Promo2", "Promo3"]
        completion(banners)
    }
    
    func loadCategories(completion: @escaping (([String]) -> Void)) {
        //Api Call
        let categories: [String] = ["Category1", "Category2", "Category3"]
        completion(categories)
    }
    
    func loadTopSellingProducts(completion: @escaping (([String]) -> Void)) {
        //Api Call
        let products: [String] = ["Product1", "Product2", "Product3"]
        completion(products)
    }
}

class HomeViewController: UIViewController {

    private(set) var homeinfoLoader: HomeInfoLoader!
    
    var banners: [String] = []
    var categories: [String] = []
    var topSellingProducts: [String] = []
    
    convenience init(homeInfoLoader: HomeInfoLoader) {
        self.init()
        self.homeinfoLoader = homeInfoLoader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeinfoLoader?.loadBanners { (banners) in
            self.banners = banners
        }
        
        homeinfoLoader?.loadCategories { (categories) in
            self.categories = categories
        }
        
        homeinfoLoader?.loadTopSellingProducts { (products) in
            self.topSellingProducts = products
        }
    }
    
}

class HomeViewControllerTests: XCTestCase {

    func test_homeViewController_shouldHaveBannersToShow_afterLoadingView() {
        let sut = HomeViewController(homeInfoLoader: RemoteHomeInfoLoader())
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.banners.count > 0)
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
    
}
