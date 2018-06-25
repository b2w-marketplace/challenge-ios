//
//  ProductPresenterFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 20/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

enum ProductPresenterFactory {
    static func make(delegate: ProductPresentation, interactor: ProductInteractor) -> ProductPresenter {
        return ProductPresenter(delegate: delegate, interactor: interactor)
    }
}
