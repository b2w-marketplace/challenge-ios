//
//  HomeViewModel.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

enum HomeSections {
    case categories
    case topSellingProducts
}

protocol HomeServicesDelegate: class {
    func didLoadBanners()
    func didLoadCategories()
    func didLoadTopSellingProducts()
}

protocol HomeViewModelType {
    
    var banners: [Banner] { get set }
    var categories: [ProductCategory] { get set }
    var topSellingProducts: [Product] { get set }
    var homeSections: [HomeSections] { get }
    
    func loadBanners()
    func loadCategories()
    func loadTopSellingProducts()
    
    var homeServicesDelegate: HomeServicesDelegate? { get set }
}

class HomeViewModel: HomeViewModelType {
    
    var banners: [Banner] = [] {
        didSet {
            homeServicesDelegate?.didLoadBanners()
        }
    }
    
    var categories: [ProductCategory] = [] {
        didSet {
            homeServicesDelegate?.didLoadCategories()
        }
    }
    
    var topSellingProducts: [Product] = [] {
        didSet {
            homeServicesDelegate?.didLoadTopSellingProducts()
        }
    }
    
    // Categories and TopSellingProducts sections
    var homeSections: [HomeSections] = [.categories, .topSellingProducts]
     
    weak var homeServicesDelegate: HomeServicesDelegate?
    
    var service: HomeServiceGateway!
    init(service: HomeServiceGateway) {
        self.service = service
    }
    
    // Load Banners
    func loadBanners() {
        service.loadBanners { (result: Result<[Banner]>) in
            switch result {
            case .success(let banners):
                self.banners = banners
            case .failure(_):
                self.banners = []
            }
        }
    }
    
    // Load Categories
    func loadCategories() {
        service.loadCategories { (result: Result<[ProductCategory]>) in
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(_):
                self.categories = []
            }
        }
    }
    
    // Load TopSellingProducts
    func loadTopSellingProducts() {
        service.loadTopSellingProducts { (result: Result<[Product]>) in
            switch result {
            case .success(let products):
                self.topSellingProducts = products
            case .failure(_):
                self.topSellingProducts = []
            }
        }
    }
    
}
