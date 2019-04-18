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
    
    func fetchProducts(productEncodable: ProductEncodable) -> Single<[Product]>
    func fetchProductDetail(productId: Int) -> Single<Product>
    
}

// MARK: - Interactor
protocol HomeInteractorProtocol: class {
    
    var categoriesObservable: Single<[Category]> { get }
    var bannesObservable: Single<[Banner]> { get }
    var topSellingProductListObservable: Single<[Product]> { get }
    
    func fetchProducts(offset: Int, limit: Int, categoriaId: Int) -> Single<[Product]>
    func fetchProductDetail(productId: Int) -> Single<Product>
    
}

// MARK: - Presenter
protocol HomePresenterProtocol: class {

    var view: HomeViewProtocol! { get set }
    var router: HomeRouterProtocol! { get set }
    var interactor: HomeInteractorProtocol! { get set }
    
    func viewDidLoad()
    
}

// MARK: - View
protocol HomeViewProtocol: class {
    
    var presenter: HomePresenterProtocol! { get set }
    
    func setup(bannerList: [Banner])
    func setup(categoryList: [Category])
    func setup(topSellingProductList: [Product])
    func showAlert(message: String)
    
}

// MARK: - Router
protocol HomeRouterProtocol: class {
    
    var viewController: UIViewController! { get set }
    
}
