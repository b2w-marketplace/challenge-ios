//
//  ProductsViewController.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var productsView: ProductsView!
    fileprivate var categoryId: Int!
    fileprivate var categoryName: String!
    private lazy var presenter: ProductsPresenter = ProductsPresenterFactory.make(delegate: self, interactor: ProductsInteractorFactory.make())
    
    override func viewWillAppear(_ animated: Bool) {
        assertDependencies()
        presenter.getProducts(idCategory: categoryId)
        title = categoryName
    }

}

extension ProductsViewController: Injectable {
    func inject(_ value: (Int, String)) {
        self.categoryId = value.0
        self.categoryName = value.1
    }
    
    func assertDependencies() {
        assert(categoryId != nil)
        assert(categoryName != nil)
    }
}

extension ProductsViewController: ProductsPresentation {
    func onLoading() {
        productsView.presentLoading()
    }
    
    func offLoading() {
        productsView.dismissLoading()
    }
    
    func onError(error: NetworkError) {
        productsView.presentError(error: error)
    }
    
    func onProducts(products: [ProductViewModel]) {
        productsView.setupView(withScroll: true, withInfinite: true, products: products, completionProdructIndex: { (index) in
            self.goToProductDetail(productId: self.presenter.productIdIndex(index: index))
        }) {
            self.presenter.getProducts(idCategory: self.categoryId)
        }
    }
}

extension ProductsViewController {
    func goToProductDetail(productId: Int) {
        guard let viewController = R.storyboard.home.productDetailViewController() else { return}
        viewController.loadViewIfNeeded()
        viewController.inject(productId)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
