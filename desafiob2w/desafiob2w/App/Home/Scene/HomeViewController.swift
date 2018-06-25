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
    
    lazy var presenter: HomePresenter = HomePresenterFactory.make(delegate: self, interactor: HomeInteractorFactory.make())
        
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
            self.goToProducts(categoryId: self.presenter.categoryIdForIndex(index: index), categoryName: self.presenter.categoryDescriptionIndex(index: index))
        }
    }
    
    func onProducts(products: [ProductViewModel]) {
        updateProductsHeightConstraint(count: products.count)
        bestSellingProductView.setupView(products: products) { (index) in
            self.goToProductDetail(productId: self.presenter.productIdForIndex(index: index))
        }
    }
    
    func onBanners(banners: [BannerViewModel]) {
        bannersView.setupView(banners: banners) { (index) in
            
        }
    }
}

// #MARK Navigation Router
extension HomeViewController {
    
    func goToProductDetail(productId: Int) {
        guard let viewController = R.storyboard.home.productDetailViewController() else { return}
        viewController.loadViewIfNeeded()
        viewController.inject(productId)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToProducts(categoryId: Int, categoryName: String) {
        guard let viewController = R.storyboard.home.productsViewController() else { return}
        viewController.loadViewIfNeeded()
        viewController.inject((categoryId, categoryName))
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
