//
//  HomeProtocols.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

// MARK: - DataManager
protocol HomeRemoteDataManagerProtocol: class {
    
    var categoriesObservable: Single<[Category]> { get }
    var bannesObservable: Single<[Banner]> { get }
    var topSellingProductListObservable: Single<[Product]> { get }
    
}

// MARK: - Interactor
protocol HomeInteractorProtocol: class {
    
    var categoriesObservable: Single<[Category]> { get }
    var bannesObservable: Single<[Banner]> { get }
    var topSellingProductListObservable: Single<[Product]> { get }
    
}

// MARK: - Presenter
protocol HomePresenterProtocol: class {

    var view: HomeViewProtocol! { get set }
    var router: HomeRouterProtocol! { get set }
    var interactor: HomeInteractorProtocol! { get set }
    
    func viewDidLoad()
    func didSelectCategory(category: Category)
    func didSelectProduct(product: Product)
    
}

// MARK: - View
protocol HomeViewProtocol: class {
    
    var presenter: HomePresenterProtocol! { get set }
    
    func setup(bannerList: [Banner])
    func setup(categoryList: [Category])
    func setup(topSellingProductList: [Product])
    func showAlert(message: String)
    func showActiveIndicator()
    func hideActiveIndicator()
    
}

// MARK: - Router
protocol HomeRouterProtocol: class {
    
    var viewController: UIViewController! { get set }
    
    func presentProductListScreen(category: Category)
    func presentProductDetailScreen(product: Product)
    
}
