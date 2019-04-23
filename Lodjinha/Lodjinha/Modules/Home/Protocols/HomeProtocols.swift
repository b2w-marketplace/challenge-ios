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
    
    var bannerList: [Banner] { get }
    var categoryList: [Category] { get }
    var productList: [Product] { get }
    
    func loadData() -> Completable
    
}

// MARK: - Interactor
protocol HomeInteractorProtocol: class {
    
    var bannerList: [Banner] { get }
    var categoryList: [Category] { get }
    var numberOfProducts: Int { get }
    
    func loadData() -> Completable
    func product(at index: Int) -> Product
    
}

// MARK: - Presenter
protocol HomePresenterProtocol: class {

    var view: HomeViewProtocol! { get set }
    var router: HomeRouterProtocol! { get set }
    var interactor: HomeInteractorProtocol! { get set }
    
    var bannerList: [Banner] { get }
    var categoryList: [Category] { get }
    var numberOfProducts: Int { get }

    func viewDidLoad()
    func category(at index: Int) -> Category
    func product(at index: Int) -> Product
    func didSelectCategory(category: Category)
    func didSelectProduct(product: Product)
    
}

// MARK: - View
protocol HomeViewProtocol: class {
    
    var presenter: HomePresenterProtocol! { get set }
    
    func updateView()
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
