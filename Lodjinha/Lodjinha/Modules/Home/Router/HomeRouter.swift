//
//  HomeRouter.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

final class HomeRouter: HomeRouterProtocol, Storyboarded {
    
    static let storyboardName = "Home"
    
    weak var viewController: UIViewController!
    
    static func assembleModule() -> UIViewController {
        let view: HomeViewController = storyboard.instantiateViewController()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let remoteDataManager = HomeRemoteDataManager()
        let interactor = HomeInteractor(remoteDataManager: remoteDataManager)
        
        view.presenter = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
    
}

// MARK: - TabBarViewControllerProtocol
extension HomeRouter: TabBarViewControllerProtocol {
    
    var tabNormalIcon: UIImage {
        return UIImage(identifier: .homeDeselected) ?? UIImage()
    }
    
    var tabSelectedIcon: UIImage {
        return UIImage(identifier: .homeActive) ?? UIImage()
    }
    
    var tabTitle: String {
        return String(identifier: .home)
    }
    
    func configuredViewController() -> UIViewController {
        return HomeRouter.assembleModule()
    }
    
}
