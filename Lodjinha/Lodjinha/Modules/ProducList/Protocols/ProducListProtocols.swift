//
//  ProducListProtocols.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

// MARK: - Interactor
protocol ProducListInteractorProtocol: class {
    
    var numberOfProducts: Int { get }
    
    func fetchProducts(withFilter filter: ProductFilter) -> Single<[Product]>
    func product(at index: Int) -> Product
    
}

// MARK: - DataManager
protocol ProducListRemoteDataManagerProtocol: class {
    
    func fetchProducts(productEncodable: ProductEncodable) -> Single<[ProductDecodable]>
    
}

// MARK: - Repository
protocol ProducListRepositoryProtocol {
    
    var numberOfProducts: Int { get }
    
    func fetchProducts(withFilter filter: ProductFilter) -> Single<[Product]>
    func product(at index: Int) -> Product
    
}

// MARK: - Presenter
protocol ProducListPresenterProtocol: class {
    
    var view: ProducListViewProtocol! { get set }
    var router: ProducListRouterProtocol! { get set }
    var interactor: ProducListInteractorProtocol! { get set }
    var title: String { get }
    var currentFilter: ProductFilter { get }
    var numberOfProducts: Int { get }
    
    func viewDidLoad()
    func fetchProducts(withFilter filter: ProductFilter)
    func product(at index: Int) -> Product
    
}

// MARK: - View
protocol ProducListViewProtocol: class {
    
    var presenter: ProducListPresenterProtocol! { get set }
    
    func updateView()
    func showAlert(message: String)
    func showEmptyState()
    func hideEmptyState()
    func showActiveIndicator()
    func hideActiveIndicator()
    
}

// MARK: - Router
protocol ProducListRouterProtocol: class {
    
    var viewController: UIViewController! { get set }
    
}


