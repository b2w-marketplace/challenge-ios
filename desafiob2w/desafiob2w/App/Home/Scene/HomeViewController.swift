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
    @IBOutlet weak var productsView: ProductsView!
    @IBOutlet weak var productsHeightConstraint: NSLayoutConstraint!
    
    fileprivate lazy var presenter: HomePresenter = HomePresenterFactory.make(delegate: self)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getCategories()
        presenter.getProducts()
        presenter.getBanners()
    }

    private func updateProductsHeightConstraint(count: Int) {
        productsHeightConstraint.constant = CGFloat(260 + (count * 80))
    }
}

extension HomeViewController: HomePresentation {
  
    
    func onLoadingCategories() {}
    func offLoadingCategories() {}
    func offLoadingProducts() {}
    func onLoadingProducts() {}
    func onLoadingBanners() {}
    func offLoadingBanners() {}
    func onErrorCategories(error: NetworkError) {}
    func onErrorProducts(error: NetworkError) {}
    func onErrorBanners(error: NetworkError) {}

    func onCategories(categories: [CategoryViewModel]) {
        categoriesView.setupView(categories: categories)
    }
    
    func onProducts(products: [ProductViewModel]) {
        productsView.setupView(products: products)
        updateProductsHeightConstraint(count: products.count)
    }
    
    func onBanners(banners: [BannerViewModel]) {
        bannersView.setupView(banners: banners)
    }
    
}

