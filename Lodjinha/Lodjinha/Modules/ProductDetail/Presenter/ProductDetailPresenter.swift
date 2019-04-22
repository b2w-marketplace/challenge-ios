//
//  ProductDetailPresenter.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    weak var view: ProductDetailViewProtocol!
    var router: ProductDetailRouterProtocol!
    var interactor: ProductDetailInteractorProtocol!
    
}
