//
//  HomeNavigationRouterFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

enum HomeNavigationRouterFactory {
    static func make(navigationController: UINavigationController) -> HomeRouter {
        return HomeNavigationRouter(navigationController: navigationController)
    }
}
