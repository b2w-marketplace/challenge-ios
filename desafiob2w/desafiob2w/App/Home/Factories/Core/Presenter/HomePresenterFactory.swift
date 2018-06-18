//
//  HomePresenterFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct HomePresenterFactory {
    static func make(delegate: HomePresentation, interactor: HomeInteractor) -> HomePresenter {
        return HomePresenter(delegate: delegate, interactor: interactor)
    }
}
