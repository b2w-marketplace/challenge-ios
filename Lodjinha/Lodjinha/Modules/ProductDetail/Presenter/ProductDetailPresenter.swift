//
//  ProductDetailPresenter.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import RxSwift

final class ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    weak var view: ProductDetailViewProtocol!
    var router: ProductDetailRouterProtocol!
    var interactor: ProductDetailInteractorProtocol!
    
    private let disposeBag = DisposeBag()
    
    var title: String {
        return interactor.title
    }
    
    func viewDidLoad() {
        fetchProductDetails()
    }
    
    func didSelectButtonReservation() {
        productReservation()
    }
    
    private func fetchProductDetails() {
        view.showActiveIndicator()
        interactor.productDetailObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] product in
                self?.view.hideEmptyState()
                self?.view.hideActiveIndicator()
                self?.view.setup(product: product)
            }, onError: { [weak self] error in
                self?.view.showEmptyState()
                self?.view.hideActiveIndicator()
                self?.view.showAlert(message: String(identifier: .serviceErrorMessage))
            })
            .disposed(by: disposeBag)
    }
    
    private func productReservation() {
        view.showActiveIndicator()
        interactor.productReservation()
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.view.hideActiveIndicator()
                self?.view.showAlert(message: String(identifier: .successReservation), actionHandler: { _ in
                    self?.router.presentPreviousScreen()
                })
                }, onError: { [weak self] error in
                    self?.view.hideActiveIndicator()
                    self?.view.showAlert(message: String(identifier: .serviceErrorMessage))
            })
            .disposed(by: disposeBag)
    }
    
    
}
