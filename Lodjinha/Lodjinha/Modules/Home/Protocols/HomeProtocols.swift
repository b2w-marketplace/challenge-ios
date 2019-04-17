//
//  HomeProtocols.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Presenter
protocol HomePresenterProtocol: class {

    var view: HomeViewProtocol! { get set }
    var router: HomeRouterProtocol! { get set }
    
}

// MARK: - View
protocol HomeViewProtocol: class {
    
    var presenter: HomePresenterProtocol! { get set }
    
    func showAlert(message: String)
    
}

// MARK: - Router
protocol HomeRouterProtocol: class {
    
    var viewController: UIViewController! { get set }
    
}
