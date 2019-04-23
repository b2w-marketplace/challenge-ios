//
//  ProductDetailProtocols.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

// MARK: - Interactor
protocol ProductDetailInteractorProtocol: class {
    
    var title: String { get }
    var productDetailObservable: Single<Product> { get }
    
    func productReservation() -> Completable
    
}

// MARK: - DataManager
protocol ProductDetailRemoteDataManagerProtocol: class {
    
    func fetchProductDetail(productId: Int) -> Single<Product>
    func productReservation(productId: Int) -> Completable
    
}

// MARK: - Presenter
protocol ProductDetailPresenterProtocol: class {
    
    var view: ProductDetailViewProtocol! { get set }
    var router: ProductDetailRouterProtocol! { get set }
    var interactor: ProductDetailInteractorProtocol! { get set }
    
    var title: String { get }
    
    func viewDidLoad()
    func didSelectButtonReservation()
    
}

// MARK: - View
protocol ProductDetailViewProtocol: class {
    
    var presenter: ProductDetailPresenterProtocol! { get set }
    
    func setup(product: Product)
    func showAlert(message: String)
    func showAlert(message: String, actionHandler: @escaping ((UIAlertAction) -> Void))
    func showEmptyState()
    func hideEmptyState()
    func showActiveIndicator()
    func hideActiveIndicator()
    
}

// MARK: - Router
protocol ProductDetailRouterProtocol: class {
    
    var viewController: UIViewController! { get set }
    
    func presentPreviousScreen()
    
}


