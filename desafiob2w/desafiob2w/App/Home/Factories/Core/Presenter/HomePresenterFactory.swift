//
//  HomePresenterFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

enum HomePresenterFactory {
    static func make(delegate: HomePresentation, navigationController: UINavigationController) -> HomePresenter {
        return HomePresenter(delegate: delegate, interactor: HomeInteractorFactory.make(), router: HomeNavigationRouterFactory.make(navigationController: navigationController))
    }
}
