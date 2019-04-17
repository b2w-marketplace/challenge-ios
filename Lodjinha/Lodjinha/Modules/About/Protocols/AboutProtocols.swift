//
//  AboutProtocols.swift
//  Lodjinha
//
//  Created on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Presenter
protocol AboutPresenterProtocol: class {
    
    var view: AboutViewProtocol! { get set }
    var router: AboutRouterProtocol! { get set }
    
}

// MARK: - View
protocol AboutViewProtocol: class {
    
    var presenter: AboutPresenterProtocol! { get set }
    
}

// MARK: - Router
protocol AboutRouterProtocol: class {
    
    var viewController: UIViewController! { get set }
    
}


