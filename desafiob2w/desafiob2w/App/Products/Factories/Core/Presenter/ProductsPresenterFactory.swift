//
//  ProductsPresenterFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 20/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

enum ProductsPresenterFactory {
    static func make(delegate: ProductsPresentation, interactor: ProductsInteractor) -> ProductsPresenter {
        return ProductsPresenter(delegate: delegate, interactor: interactor)
    }
}
