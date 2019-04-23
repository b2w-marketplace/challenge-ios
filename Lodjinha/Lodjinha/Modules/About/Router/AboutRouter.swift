//
//  AboutRouter.swift
//  Lodjinha
//
//  Created on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class AboutRouter: AboutRouterProtocol, Storyboarded {
    
    static let storyboardName = "About"
    
    weak var viewController: UIViewController!
    
    static func assembleModule() -> UIViewController {
        let view: AboutViewController = storyboard.instantiateViewController()
        let presenter = AboutPresenter()
        let router = AboutRouter()
        
        view.presenter = presenter
        
        router.viewController = view
        
        presenter.view = view
        presenter.router = router

        return view
    }

}

// MARK: - TabBarViewControllerProtocol
extension AboutRouter: TabBarViewControllerProtocol {
    
    var tabNormalIcon: UIImage {
        return UIImage(identifier: .tagDeselected) ?? UIImage()
    }
    
    var tabSelectedIcon: UIImage {
        return UIImage(identifier: .tagSelected) ?? UIImage()
    }
    
    var tabTitle: String {
        return String(identifier: .about)
    }
    
    func configuredViewController() -> UIViewController {
        return AboutRouter.assembleModule()
    }
    
}
