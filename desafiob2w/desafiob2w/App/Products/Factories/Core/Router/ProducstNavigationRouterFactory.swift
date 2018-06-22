//
//  ProducstNavigationRouterFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 22/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

enum ProducstNavigationRouterFactory {
    static func make(navigationController: UINavigationController) -> ProductsRouter {
        return ProductsNavigationRouter(navigationController: navigationController)
    }
}
