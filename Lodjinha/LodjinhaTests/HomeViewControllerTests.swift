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

protocol CategoriesLoader {
    func load(completion: @escaping (([String]) -> Void))
}

protocol TopSellingProductsLoader {
    func load(completion: @escaping (([String]) -> Void))
}

class RemoteBannerLoader: BannersLoader {
    func load(completion: @escaping (([String]) -> Void)) {
        //Api Call
        let banners: [String] = ["Promo1", "Promo2", "Promo3"]
        completion(banners)
    }
}

class RemoteCategoriesLoader: CategoriesLoader {
    func load(completion: @escaping (([String]) -> Void)) {
        //Api Call
        let categories: [String] = ["Category1", "Category2", "Category3"]
        completion(categories)
    }
}

class RemoteTopSellingProductsLoader: TopSellingProductsLoader {
    func load(completion: @escaping (([String]) -> Void)) {
        //Api Call
        let products: [String] = ["Product1", "Product2", "Product3"]
        completion(products)
    }
}

class HomeViewController: UIViewController {
    
    var bannerLoader: BannersLoader!
    var categoriesLoader: CategoriesLoader!
    var topSellingProductsLoader: TopSellingProductsLoader!
    
    var banners: [String] = []
    var categories: [String] = []
    var topSellingProducts: [String] = []
    
    convenience init(bannerLoader: BannersLoader, categoriesLoader: CategoriesLoader, topSellingProductsLoader: TopSellingProductsLoader) {
        self.init()
        self.bannerLoader = bannerLoader
        self.categoriesLoader = categoriesLoader
        self.topSellingProductsLoader = topSellingProductsLoader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerLoader?.load { (banners) in
            self.banners = banners
        }
        
        categoriesLoader?.load { (categories) in
            self.categories = categories
        }
        
        topSellingProductsLoader?.load { (products) in
            self.topSellingProducts = products
        }
    }
    
}

class HomeViewControllerTests: XCTestCase {

    func test_homeViewController_shouldHaveBannersToShow_afterLoadingView() {
        let sut = HomeViewController(bannerLoader: RemoteBannerLoader(), categoriesLoader: RemoteCategoriesLoader(), topSellingProductsLoader: RemoteTopSellingProductsLoader())
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.banners.count > 0)
    }
    
    func test_homeViewController_shoulHaveCategoriesToShow_afterLoadingView() {
        let sut = HomeViewController(bannerLoader: RemoteBannerLoader(), categoriesLoader: RemoteCategoriesLoader(), topSellingProductsLoader: RemoteTopSellingProductsLoader())
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.categories.count > 0)
    }
    
    func test_homeViewController_shouldHaveTopSellingProductsToShow_afterLoadingView() {
        let sut = HomeViewController(bannerLoader: RemoteBannerLoader(), categoriesLoader: RemoteCategoriesLoader(), topSellingProductsLoader: RemoteTopSellingProductsLoader())
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.topSellingProducts.count > 0)
    }
}
