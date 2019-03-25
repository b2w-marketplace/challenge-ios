//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 25/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

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
    
    var categories: [String] = []
    var topSellingProducts: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannersView: HomeBannersView!
    
    convenience init(homeInfoLoader: HomeInfoLoader) {
        self.init(nibName: String(describing: HomeViewController.self), bundle: Bundle.main)
        self.homeinfoLoader = homeInfoLoader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeinfoLoader?.loadBanners { (banners) in
            self.bannersView.updateBanners(banners: banners)
        }
        
        homeinfoLoader?.loadCategories { (categories) in
            self.categories = categories
        }
        
        homeinfoLoader?.loadTopSellingProducts { (products) in
            self.topSellingProducts = products
        }
    }
    
}
