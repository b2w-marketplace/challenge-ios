//
//  ProductPresenter.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

class ProductPresenter {
    
    private weak var delegate: ProductPresentation?
    private let interactor: ProductInteractor
    
    private var product: Product? {
        didSet {
            guard let product = product else {return}
            let productViewModel = ProductViewModel(product: product)
            self.delegate?.onProduct(product: productViewModel)        }
    }
    
    init(delegate: ProductPresentation, interactor: ProductInteractor) {
        self.delegate = delegate
        self.interactor = interactor
    }
    
    func getProduct(productId: Int) {
        interactor.fetchProduct(idProduct: productId) { (result) in
            self.delegate?.onLoading()
            switch result {
            case .success(let product):
                self.product = product
            case .fail(let error):
                self.delegate?.onError(error: error)
            }
            self.delegate?.offLoading()
        }
    }
    
    func setReserveProduct() {
        interactor.submitReserveProduct(idProduct: (product?.id)!) { (result) in
            self.delegate?.onLoading()
            switch result {
            case .success(_ ):
                self.delegate?.onReserved(message: R.string.messages.reservedSuccess())
            case .fail(let error):
                self.delegate?.onReserved(message: error.localizedDescription)
            }
            self.delegate?.offLoading()
        }
    }
}
