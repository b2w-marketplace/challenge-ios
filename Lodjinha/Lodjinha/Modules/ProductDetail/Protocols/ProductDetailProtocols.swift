//
//  ProductDetailProtocols.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Interactor
protocol ProductDetailInteractorProtocol: class {
    
}

// MARK: - DataManager
protocol ProductDetailRemoteDataManagerProtocol: class {
    
}

// MARK: - Presenter
protocol ProductDetailPresenterProtocol: class {
    
    var view: ProductDetailViewProtocol! { get set }
    var router: ProductDetailRouterProtocol! { get set }
    var interactor: ProductDetailInteractorProtocol! { get set }
    
}

// MARK: - View
protocol ProductDetailViewProtocol: class {
    
    var presenter: ProductDetailPresenterProtocol! { get set }
    
}

// MARK: - Router
protocol ProductDetailRouterProtocol: class {
    
    var viewController: UIViewController! { get set }
    
}


