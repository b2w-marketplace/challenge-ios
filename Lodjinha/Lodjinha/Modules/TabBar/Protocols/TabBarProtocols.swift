//
//  TabBarProtocols.swift
//  Lodjinha
//
//  Created on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Presenter
protocol TabBarPresenterProtocol: class {
    
    var view: TabBarViewProtocol! { get set }
    var router: TabBarRouterProtocol! { get set }
    
}

// MARK: - View
protocol TabBarViewProtocol: class {
    
    var presenter: TabBarPresenterProtocol! { get set }
    
}

// MARK: - Router
protocol TabBarRouterProtocol: class {
    
    var rootRouter: RootRouter? { get set }
    
}


