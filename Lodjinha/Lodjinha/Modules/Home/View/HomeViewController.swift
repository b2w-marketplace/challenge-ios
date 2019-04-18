//
//  ViewController.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var presenter: HomePresenterProtocol!
    
    private var bannerList: [Banner] = []
    private var categoryList: [Category] = []
    private var topSellingProductList: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
        applyLanguage()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        applyStyle()
    }
    
    // MARK: - Setup Methods
    private func setupAccessibilityIdentifiers() {
        
    }
    
    private func applyLanguage() {
        
    }
    
    private func applyStyle() {
        Style.apply(onNavigationBarWithImageTitle: navigationItem)
    }

}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
    func setup(bannerList: [Banner]) {
        self.bannerList = bannerList
    }
    
    func setup(categoryList: [Category]) {
        self.categoryList = categoryList
    }
    
    func setup(topSellingProductList: [Product]) {
        self.topSellingProductList = topSellingProductList
    }
    
    func showAlert(message: String) {
        presentAlert(message: message)
    }
    
}

