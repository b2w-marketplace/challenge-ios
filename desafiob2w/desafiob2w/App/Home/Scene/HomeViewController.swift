//
//  HomeViewController.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate lazy var presenter: HomePresenter = HomePresenterFactory.make(delegate: self, interactor: HomeInteractorFactory.make())
    
    
    private var categories: [Category] = [] {
        didSet {
            
        }
    }
    
    private var products: [Product] = [] {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getCategories()
        presenter.getProducts()
    }

}

extension HomeViewController: HomePresentation {
    func onLoadingCategories() {}
    func offLoadingCategories() {}
    func offLoadingProducts() {}
    func onLoadingProducts() {}
    
    func onErrorCategories(error: NetworkError) {
        
    }
    
    func onErrorProducts(error: NetworkError) {
        
    }
    
    func onCategories(categories: [Category]) {
        self.categories = categories
    }
    
    func onProducts(products: [Product]) {
        self.products = products
    }
    
}

