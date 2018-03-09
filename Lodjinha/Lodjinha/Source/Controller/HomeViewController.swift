//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let homeManager = HomeManager(maxConcurrentOperationCount: 200)
    private var banners : [Banner]?
    private var categories : [Category]?
    private var topSelledProducts : [Product]?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHomeScreen()
    }
    
    // MARK: - General Methods
    
    private func loadHomeScreen() {
        loadBanners()
        loadCategories()
        loadTopSelledProducts()
    }
    
    private func loadBanners() {
        homeManager.fetchBanners { (banners) in
            self.banners = banners().data
            print(self.banners)
        }
    }
    
    private func loadCategories() {
        homeManager.fetchCategories { (categories) in
            self.categories = categories()
        }
    }
    
    private func loadTopSelledProducts() {
        homeManager.fetchTopSelledProducts { (products) in
            self.topSelledProducts = products()
        }
    }
    
    // MARK: - Actions

}
