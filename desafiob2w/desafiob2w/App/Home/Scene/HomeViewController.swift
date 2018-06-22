//
//  HomeViewController.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var bannersView: BannersView!
    @IBOutlet weak var categoriesView: CategoriesView!
    @IBOutlet weak var bestSellingProductView: ProductsView!
    @IBOutlet weak var productsHeightConstraint: NSLayoutConstraint!
    
    private lazy var presenter: HomePresenter = HomePresenterFactory.make(delegate: self, navigationController: self.navigationController!)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getCategories()
        presenter.getProducts()
        presenter.getBanners()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.titleView = TabBarImageViewFactory.make()
    }

    private func updateProductsHeightConstraint(count: Int) {
        productsHeightConstraint.constant = CGFloat(260 + (count * 80))
    }
}

extension HomeViewController: HomePresentation {
    
    func onLoadingBanners() {
        bannersView.presentLoading()
    }
    
    func offLoadingBanners() {
        bannersView.dismissLoading()
    }
    
    func onLoadingCategories() {
        categoriesView.presentLoading()
    }
    
    func offLoadingCategories() {
        categoriesView.dismissLoading()
    }
    
    func onLoadingProducts() {
        bestSellingProductView.presentLoading()
    }
    
    func offLoadingProducts() {
        bestSellingProductView.dismissLoading()
    }
    
    func onErrorCategories(error: NetworkError) {
        categoriesView.presentError(error: error)
    }
    
    func onErrorProducts(error: NetworkError) {
        bestSellingProductView.presentError(error: error)
    }
    
    func onErrorBanners(error: NetworkError) {
        bannersView.presentError(error: error)
    }
    
    func onCategories(categories: [CategoryViewModel]) {
        categoriesView.setupView(categories: categories) { (index) in
            self.presenter.showCategory(index: index)
        }
    }
    
    func onProducts(products: [ProductViewModel]) {
        updateProductsHeightConstraint(count: products.count)
        bestSellingProductView.setupView(products: products) { (index) in
            self.presenter.showProduct(index: index)
        }
    }
    
    func onBanners(banners: [BannerViewModel]) {
        bannersView.setupView(banners: banners) { (index) in
            
        }
    }
    
}

